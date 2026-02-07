export interface CategoryMeta {
  slug: string;
  label: string;
  description: string;
}

export const CATEGORIES: CategoryMeta[] = [
  {
    slug: "bottom_bracket",
    label: "Bottom Bracket Threading",
    description:
      "Shell threading standards — ISO/English, Italian, French, and Swiss",
  },
  {
    slug: "bb_spindle",
    label: "BB Spindle Interface",
    description:
      "Crank-to-spindle interfaces — JIS square taper, ISO square taper, cottered",
  },
  {
    slug: "headset",
    label: "Headsets",
    description:
      "Headset sizes and types — 1-inch threaded, 1-1/8 threadless, French, Italian",
  },
  {
    slug: "hub_spacing",
    label: "Rear Dropout Spacing",
    description:
      "Over-locknut distance — 120mm track through 135mm mountain",
  },
  {
    slug: "seatpost",
    label: "Seatpost Diameters",
    description:
      "Seat tube inner diameters — 25.0mm through 27.2mm",
  },
  {
    slug: "stem",
    label: "Quill Stems",
    description:
      "Quill stem diameters — ISO 22.2mm vs French 22.0mm",
  },
  {
    slug: "handlebar",
    label: "Handlebar Clamp",
    description:
      "Bar clamp diameters — ISO 25.4mm vs Italian 26.0mm",
  },
  {
    slug: "wheel_size",
    label: "Wheel Sizes",
    description:
      "Rim bead seat diameters — 700c, 27\", 650b, 26\"",
  },
  {
    slug: "drivetrain",
    label: "Drivetrain Type",
    description:
      "Freewheel vs freehub (cassette) hub designs",
  },
  {
    slug: "shifting",
    label: "Shifting Systems",
    description:
      "Friction vs indexed shifting compatibility",
  },
];

export function getCategoryBySlug(slug: string): CategoryMeta | undefined {
  return CATEGORIES.find((c) => c.slug === slug);
}
