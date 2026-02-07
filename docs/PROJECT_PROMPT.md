# Bike Part Compatibility Database — Claude Code Project Prompt

> **META: This file lives at `docs/PROJECT_PROMPT.md` in the repo. It is the source of truth for project direction, architecture decisions, and current status. After each working session, update the "Current Status" section below with what was completed, what changed, and what's next. If any architecture decisions change during implementation, update the relevant sections of this document to reflect reality — don't let the prompt drift from the codebase.**

## Current Status

**Last updated**: 2026-02-07
**Current phase**: Phase 1A complete
**What's done**: Project scaffolded (Next.js 16 + TypeScript + Tailwind + Supabase client). Database migration SQL created (5 tables: standards, compatibility_rules, components, groupsets, measurement_conversions). Seed data written (~30 standards, 18 compatibility rules, 21 measurement conversions). Basic layout with Header/Footer and 3 placeholder routes (compatibility, standards, converter). All pages build and render.
**What's next**: Phase 1B — interactive compatibility checker UI. Also: set real Supabase credentials in .env.local, run migrations and seed SQL in Supabase SQL Editor.
**Open questions**: Owner needs to provide Supabase URL and anon key for .env.local
**Deviations from plan**: None yet

---

## Project Overview

Build a web application that serves as a comprehensive bicycle part compatibility database, with a primary focus on vintage/older bike parts. The app helps users answer the fundamental question: **"Will this part work with my bike?"**

This is a real product intended to eventually generate revenue through ads, affiliate links, and a pro tier. Architecture decisions should support that trajectory from day one.

The primary authoritative source for compatibility data is **Sheldon Brown's website** (sheldonbrown.com). Secondary sources include bike forums (BikeForums.net, Bike Index, Reddit r/bikewrench, r/vintagebicycles), Park Tool's repair guides, and manufacturer documentation. Every compatibility rule in the database should cite its source.

---

## Tech Stack

Keep this simple and manageable for a non-developer owner.

- **Framework**: Next.js (App Router) with TypeScript
- **Database**: Supabase (Postgres + Auth + Row Level Security)
- **Hosting**: Vercel (deploys from GitHub)
- **Styling**: Tailwind CSS
- **Data entry**: Supabase Table Editor (the owner manages data through Supabase's built-in spreadsheet-like UI — no custom admin panel needed for Phase 1)

No additional backend services. Supabase handles auth, database, and API. Vercel handles hosting and serverless functions.

---

## Data Model

### Core Principle

Bike part compatibility is a **graph problem**. Parts connect to bikes and to each other through **interface standards**. A bottom bracket shell has a threading standard. A BB spindle must match that threading. The spindle type constrains which cranks fit. The cranks constrain chainring BCD. And so on.

The data model must capture: **Component A connects to Component B via Standard X, with these caveats.**

### Database Schema

#### `standards` table
The heart of the system. A "standard" is any interface specification that governs whether two parts are physically compatible.

```
id: uuid (primary key)
name: text (e.g., "ISO/English Threaded Bottom Bracket", "JIS Square Taper", "1-inch Threaded Headset")
category: text (e.g., "bottom_bracket", "headset", "hub_spacing", "seatpost", "stem", "threading")
description: text (detailed explanation of the standard)
measurements: jsonb (key dimensions — thread pitch, diameter, width, etc.)
aliases: text[] (other names this standard goes by — critical for vintage parts where naming was inconsistent)
era_start: text (approximate year or decade this standard appeared, e.g., "1960s", "1978")
era_end: text (null if still in use)
region: text (e.g., "French", "Italian", "Japanese", "British", "Universal")
source_url: text (primary reference, usually Sheldon Brown)
source_notes: text
created_at: timestamptz
updated_at: timestamptz
```

#### `compatibility_rules` table
The edges in the compatibility graph. Each rule defines a relationship between two standards.

```
id: uuid (primary key)
standard_a_id: uuid (references standards)
standard_b_id: uuid (references standards)
compatibility_type: text (enum: "direct_fit", "with_adapter", "partial", "incompatible")
adapter_needed: text (description of adapter if applicable, e.g., "requires shim from 27.0 to 26.8mm")
confidence: text (enum: "confirmed", "widely_reported", "anecdotal")
caveats: text (THE IMPORTANT PART — the Sheldon Brown wisdom, e.g., "Fits but chainline will be 3mm outboard of ideal")
source_url: text
source_notes: text
created_at: timestamptz
updated_at: timestamptz
```

#### `components` table
Specific real-world parts that implement standards.

```
id: uuid (primary key)
name: text (e.g., "Shimano 600 EX Crankset")
manufacturer: text
model: text
year_start: text
year_end: text
category: text (e.g., "crankset", "bottom_bracket", "headset", "hub", "derailleur", "stem", "seatpost")
standard_interfaces: jsonb (array of { standard_id, interface_role } — a crankset has a BB interface AND a chainring BCD interface)
specifications: jsonb (flexible key-value for part-specific measurements)
notes: text
source_url: text
image_url: text (optional)
created_at: timestamptz
updated_at: timestamptz
```

#### `groupsets` table
Collections of components that were designed together.

```
id: uuid (primary key)
name: text (e.g., "Campagnolo Nuovo Record", "Shimano 600 Arabesque")
manufacturer: text
year_start: text
year_end: text
tier: text (e.g., "professional", "sport", "touring")
region: text
component_ids: uuid[] (references components)
notes: text
source_url: text
created_at: timestamptz
updated_at: timestamptz
```

#### `measurement_conversions` table
For the unit converter feature. Bike parts use a chaotic mix of metric, imperial, French, and Italian measurements.

```
id: uuid (primary key)
category: text (e.g., "seatpost_diameter", "headset_size", "bb_threading", "wheel_size")
value_a: text (e.g., "27 x 1-1/4")
value_b: text (e.g., "630mm ISO / 32-630 ETRTO")
system_a: text (e.g., "French", "Imperial", "ISO")
system_b: text
notes: text
source_url: text
```

#### `user_bikes` table (Phase 3 — auth required)

```
id: uuid (primary key)
user_id: uuid (references auth.users)
name: text (e.g., "1983 Peugeot PH10")
frame_specs: jsonb (bb_shell_standard, head_tube_standard, dropout_spacing, seat_tube_diameter, etc.)
installed_components: jsonb (array of { slot: "bottom_bracket", component_id: uuid, standard_id: uuid })
notes: text
is_public: boolean (default false)
created_at: timestamptz
updated_at: timestamptz
```

#### `community_suggestions` table

```
id: uuid (primary key)
user_id: uuid (nullable — allow anonymous suggestions)
suggestion_type: text (enum: "correction", "new_rule", "new_component", "new_standard")
target_id: uuid (nullable — the record being corrected)
content: jsonb (the suggested change)
status: text (enum: "pending", "approved", "rejected")
reviewer_notes: text
created_at: timestamptz
```

### Row Level Security (Supabase RLS)

- `standards`, `compatibility_rules`, `components`, `groupsets`, `measurement_conversions` — public read, owner-only write (use Supabase service role for data management)
- `user_bikes` — users can only read/write their own bikes
- `community_suggestions` — authenticated users can create, only owner can update status

---

## Phase 1: Foundation

### 1A: Project Setup

- Initialize Next.js project with App Router, TypeScript, Tailwind
- Set up Supabase project and create all tables from the schema above
- Configure Supabase client in Next.js (both server and client components)
- Set up Vercel deployment from GitHub
- Create seed data script with ~20-30 initial standards covering the most common vintage compatibility questions:
  - Bottom bracket threading (ISO/English, Italian, French, Swiss)
  - Bottom bracket spindle types (JIS square taper, ISO square taper, cottered)
  - Headset sizes (1", 1-1/8", Italian, French)
  - Rear dropout spacing (120mm, 126mm, 130mm, 135mm)
  - Seatpost diameters (common sizes from 25.0 to 27.2)
  - Stem quill sizes (22.2mm, 22.0mm)
  - Handlebar clamp diameters (25.4mm, 26.0mm)
  - Wheel/tire sizing (the big mess — 700c, 27", 650b, etc.)
  - Freewheel vs freehub
  - Friction vs indexed shifting compatibility

### 1B: Core Compatibility Checker UI

The main feature. User flow:

1. **Entry point**: "What are you trying to check?" — user selects a category (bottom bracket, headset, wheels, drivetrain, seatpost, stem/bars)
2. **Standard selector**: Within the category, user picks their current standard or describes what they have (e.g., "My bike has a 68mm English-threaded BB shell")
3. **Results**: Show all compatible standards with compatibility type, required adapters, and caveats
4. **Detail view**: Click into any result to see the full explanation, source citations, and specific components that use this standard

Design should be clean, readable, information-dense but not cluttered. Think reference tool, not flashy app. Good typography, clear hierarchy.

### 1C: Browse & Search

- Browse standards by category
- Browse components by manufacturer, era, or groupset
- Full-text search across standards, components, and compatibility rules
- Groupset browser — select a groupset, see all its components and their standards

### 1D: Measurement Converter

A standalone tool page. User selects a measurement category, inputs a value, and sees all equivalent values in other systems. Priority categories:

- Wheel/tire sizes (the #1 confusion point)
- Seatpost diameters
- BB shell threading
- Headset sizes
- Stem and handlebar dimensions

---

## Phase 2: "What Fits My Bike" Flow

### Smart Bike Profiler

User enters key frame specifications (can be as few as 2-3 to start):

- BB shell width and threading
- Head tube size
- Rear dropout spacing
- Seat tube inner diameter
- Stem quill size

The app then shows a complete compatibility profile: every standard their frame supports, and all components that would work. This is the "killer feature" — it turns a reference database into a personal tool.

Include a library of common vintage frames with pre-filled specs (e.g., "1980s Japanese road bike — likely 68mm English BB, 1" threaded headset, 126mm rear spacing, 27.0mm seatpost"). User can start from a template and adjust.

---

## Phase 3: Auth & Pro Tier

### Free Tier
- Full access to compatibility checker, measurement converter, and all reference data
- Save 1 bike profile

### Pro Tier ($3-5/month via Stripe)
- Save unlimited bike profiles
- Compare components side by side
- Export compatibility reports
- Priority community suggestions
- No ads

### Implementation
- Supabase Auth (email + Google OAuth)
- Stripe integration for subscriptions
- RLS policies enforce tier limits

---

## Phase 4: SEO Content & Revenue

### Auto-Generated Compatibility Pages

For every compatibility rule in the database, generate a static page optimized for search:

- URL pattern: `/compatibility/[standard-a]-with-[standard-b]`
- Example: `/compatibility/jis-square-taper-with-iso-english-bb`
- Title: "Is [Standard A] Compatible with [Standard B]? — BikePartDB"
- Content: structured answer with compatibility type, required adapters, caveats, source citations, related standards, and components that use these standards

These pages target long-tail search queries from people working on bikes. This is the primary traffic acquisition strategy.

### Additional SEO Pages

- `/standards/[standard-slug]` — reference page for each standard
- `/groupsets/[groupset-slug]` — groupset detail pages
- `/guides/[topic]` — manually written guides on common compatibility topics (e.g., "Converting a Freewheel Hub to Cassette", "French vs English Bottom Brackets")

### Revenue

- Display ads on free tier (consider Mediavine or similar once traffic supports it — need ~50k sessions/month)
- Affiliate links to parts on eBay, Velo Orange, Rivendell, Blue Lug, etc. wherever components are mentioned
- Pro tier subscriptions

---

## Design Direction

Clean, utilitarian, reference-tool aesthetic. Not a flashy app — think of it as the spiritual successor to Sheldon Brown's site but with modern UX.

- Good typography (consider a serif for body text — the content is technical reference material)
- Information-dense layouts that respect the user's intelligence
- Muted color palette — think workshop, not app store
- Mobile-responsive but desktop-primary (people use this while wrenching, often on a laptop or tablet in the garage)
- Fast — these are reference pages, not experiences. No unnecessary animations.

---

## Key Implementation Notes

### For Claude Code

- Use Supabase's auto-generated TypeScript types (`npx supabase gen types typescript`)
- Use server components for data fetching wherever possible (faster, better SEO)
- Use `generateStaticParams` for the SEO compatibility pages — they should be statically generated at build time
- Implement proper Open Graph tags on all pages
- Add structured data (JSON-LD) for the compatibility pages — FAQ schema works well
- Set up a proper sitemap.xml that includes all generated pages

### Data Integrity

- Every compatibility rule must have a `source_url`
- The `caveats` field is the most valuable part of the database — never leave it empty when there are known issues
- Use the `confidence` field honestly — "anecdotal" is fine, it's more helpful than no data
- The `aliases` field on standards is critical for search — vintage parts have many names for the same thing

### Future Considerations (don't build yet, but don't paint yourself into a corner)

- API access for third-party apps or tools
- Integration with bike marketplace listings (eBay, Craigslist) to auto-check compatibility
- Mobile app (the web app should work well on mobile first)
- Multilingual support (bike culture is global)
- Photo identification — "upload a photo of your BB shell and we'll identify the standard" (AI feature for later)

---

## Local Setup

### Prerequisites
- Node.js (install from https://nodejs.org — use the LTS version)
- Git (comes with macOS developer tools)
- Claude Code CLI (`npm install -g @anthropic-ai/claude-code`)
- A Supabase account (https://supabase.com — free tier)

### Clone and Run
```bash
git clone https://github.com/BicycleShire/bike-comp.git
cd bike-comp
npm install
```

### Environment Variables
Create a `.env.local` file in the project root (Claude Code can do this for you):
```
NEXT_PUBLIC_SUPABASE_URL=your-supabase-url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your-anon-key
```

### Running Claude Code
From inside the repo directory:
```bash
cd bike-comp
claude
```
Then tell it: "Read docs/PROJECT_PROMPT.md and start on Phase 1A"

---

## Getting Started (First Claude Code Session)

Start with Phase 1A:

1. Scaffold the Next.js project with TypeScript and Tailwind
2. Set up Supabase connection (I will provide the Supabase URL and anon key)
3. Create the database migration files for all tables
4. Build the seed data script with initial standards (focus on bottom brackets, headsets, and rear spacing first)
5. Create the basic page layout with navigation
6. Build the compatibility checker UI (Phase 1B) — this is the MVP

The goal for the first session is a working compatibility checker that queries real data from Supabase and returns results with caveats and source citations. It doesn't need to be pretty yet, but it needs to work and the data model needs to be solid.