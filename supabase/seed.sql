-- seed.sql
-- Initial seed data for the Bike Part Compatibility Database.
-- Run this AFTER the migration files (001, 002).
--
-- Uses fixed UUIDs so compatibility_rules can reference standards by ID.
-- Data sourced primarily from Sheldon Brown (sheldonbrown.com).

-- ============================================================
-- STANDARDS
-- ============================================================

-- --- Bottom Bracket Threading ---

INSERT INTO standards (id, name, category, description, measurements, aliases, era_start, era_end, region, source_url, source_notes) VALUES
(
  'a0000000-0000-0000-0000-000000000001',
  'ISO/English/BSC Threaded Bottom Bracket',
  'bottom_bracket',
  'The most common bottom bracket threading standard worldwide. 1.370" x 24 TPI (34.8mm). Right cup is left-hand (reverse) threaded, left cup is right-hand (normal) threaded. Shell widths are 68mm (road) or 73mm (mountain). Used on virtually all British, American, and Japanese bicycles.',
  '{"thread_diameter": "1.370 in / 34.8mm", "thread_pitch": "24 TPI", "shell_width_road": "68mm", "shell_width_mtb": "73mm", "drive_side_thread": "left-hand (reverse)"}',
  ARRAY['English', 'BSC', 'BSA', 'ISO', 'British Standard Cycle'],
  '1900s', NULL, 'British/Universal',
  'https://www.sheldonbrown.com/cribsheet-threadings.html',
  'By far the most common standard. Nearly universal on non-French, non-Italian frames.'
),
(
  'a0000000-0000-0000-0000-000000000002',
  'Italian Threaded Bottom Bracket',
  'bottom_bracket',
  'Used on Italian bicycle frames. 36mm x 24 TPI. Both cups are right-hand (normal) threaded — a key difference from ISO/English. Shell width is 70mm. Common on Colnago, Bianchi, De Rosa, Masi, and other Italian frames.',
  '{"thread_diameter": "36mm / 1.417 in", "thread_pitch": "24 TPI", "shell_width": "70mm", "drive_side_thread": "right-hand (normal)"}',
  ARRAY['ITA', 'Italian 36x24'],
  '1900s', NULL, 'Italian',
  'https://www.sheldonbrown.com/cribsheet-threadings.html',
  'Both cups thread in the normal direction. Not interchangeable with ISO/English despite similar pitch.'
),
(
  'a0000000-0000-0000-0000-000000000003',
  'French Threaded Bottom Bracket',
  'bottom_bracket',
  'Used on French bicycle frames (Peugeot, Motobécane, Gitane). 35mm x 1mm pitch. Both cups are right-hand (normal) threaded. Shell width is 68mm. Notorious for being easily confused with Swiss threading.',
  '{"thread_diameter": "35mm", "thread_pitch": "1mm (metric)", "shell_width": "68mm", "drive_side_thread": "right-hand (normal)"}',
  ARRAY['French 35x1'],
  '1900s', '1990s', 'French',
  'https://www.sheldonbrown.com/cribsheet-threadings.html',
  'Obsolete but still commonly encountered on vintage French bikes. Both cups thread in normally.'
),
(
  'a0000000-0000-0000-0000-000000000004',
  'Swiss Threaded Bottom Bracket',
  'bottom_bracket',
  'Used on some Swiss frames. 35mm x 1mm pitch — same as French — but the drive side cup is LEFT-hand (reverse) threaded like ISO/English. This is the key difference from French threading.',
  '{"thread_diameter": "35mm", "thread_pitch": "1mm (metric)", "shell_width": "68mm", "drive_side_thread": "left-hand (reverse)"}',
  ARRAY['Swiss 35x1'],
  '1900s', '1980s', 'Swiss',
  'https://www.sheldonbrown.com/cribsheet-threadings.html',
  'Same dimensions as French but opposite drive-side thread direction. Rare but important to identify correctly.'
);

-- --- BB Spindle Types ---

INSERT INTO standards (id, name, category, description, measurements, aliases, era_start, era_end, region, source_url, source_notes) VALUES
(
  'b0000000-0000-0000-0000-000000000001',
  'JIS Square Taper Bottom Bracket Spindle',
  'bb_spindle',
  'Japanese Industrial Standard square taper interface for connecting cranks to the BB spindle. The taper angle is 2 degrees per side (included angle of ~4 degrees). Slightly different from ISO square taper. Used by Shimano, SunTour, Sugino, and most Japanese manufacturers.',
  '{"taper_angle": "2 degrees per side", "taper_type": "square", "standard": "JIS"}',
  ARRAY['JIS square taper', 'Japanese square taper'],
  '1960s', NULL, 'Japanese',
  'https://www.sheldonbrown.com/bbtaper.html',
  'The dominant square taper standard. Most aftermarket cranks and BBs are JIS.'
),
(
  'b0000000-0000-0000-0000-000000000002',
  'ISO Square Taper Bottom Bracket Spindle',
  'bb_spindle',
  'ISO standard square taper interface. The taper is slightly different from JIS — the end of the spindle is about 2mm wider for the same nominal length. Used by Campagnolo, Stronglight, and some European manufacturers.',
  '{"taper_angle": "2 degrees per side", "taper_type": "square", "standard": "ISO", "note": "~2mm wider than JIS at end"}',
  ARRAY['ISO square taper', 'Campagnolo taper', 'Euro taper'],
  '1960s', NULL, 'European',
  'https://www.sheldonbrown.com/bbtaper.html',
  'Campagnolo cranks require ISO taper spindles. Using JIS will result in the crank sitting ~1mm further out.'
),
(
  'b0000000-0000-0000-0000-000000000003',
  'Cottered Bottom Bracket Spindle',
  'bb_spindle',
  'Older system where cranks attach to the spindle via a steel cotter pin pressed through a hole in the crank and a flat on the spindle. Common on bikes before the mid-1980s, especially low-to-mid-range models. Cotter pins come in different diameters (9mm and 9.5mm are most common).',
  '{"attachment": "cotter pin", "common_cotter_sizes": "9mm, 9.5mm"}',
  ARRAY['cottered crank', 'cotter pin'],
  '1900s', '1980s', 'Universal',
  'https://www.sheldonbrown.com/cotters.html',
  'Still found on many vintage and utility bikes. Cotter pins are still available but consider upgrading to cotterless if the BB shell threading allows.'
);

-- --- Headset Sizes ---

INSERT INTO standards (id, name, category, description, measurements, aliases, era_start, era_end, region, source_url, source_notes) VALUES
(
  'c0000000-0000-0000-0000-000000000001',
  '1-inch Threaded Headset (ISO)',
  'headset',
  'The standard headset size for most road and touring bikes from the 1970s through the 1990s, and still used on many steel frames. Crown race seat diameter 26.4mm, head tube inner diameter 30.2mm, steerer tube outer diameter 25.4mm (1 inch).',
  '{"steerer_od": "25.4mm / 1 inch", "head_tube_id": "30.2mm", "crown_race_od": "26.4mm", "type": "threaded"}',
  ARRAY['1 inch threaded', 'standard threaded headset', 'ISO 1-inch'],
  '1960s', NULL, 'Universal',
  'https://www.sheldonbrown.com/headsets.html',
  'The most common headset size for vintage road bikes. Still in production.'
),
(
  'c0000000-0000-0000-0000-000000000002',
  '1-1/8 inch Threadless Headset',
  'headset',
  'The dominant modern headset standard. Became standard for mountain bikes in the early 1990s and road bikes by the 2000s. Uses Aheadset-style stem clamping. Steerer OD 28.6mm (1-1/8"), head tube ID 34.0mm.',
  '{"steerer_od": "28.6mm / 1-1/8 inch", "head_tube_id": "34.0mm", "crown_race_od": "30.0mm", "type": "threadless"}',
  ARRAY['1-1/8 threadless', 'Aheadset', 'oversized'],
  '1990s', NULL, 'Universal',
  'https://www.sheldonbrown.com/headsets.html',
  'Modern standard. Cannot be used in frames designed for 1-inch headsets without replacing the fork.'
),
(
  'c0000000-0000-0000-0000-000000000003',
  'Italian Headset (30.2mm head tube, 25.4mm steerer)',
  'headset',
  'Used on some Italian frames. Same steerer diameter as ISO 1-inch (25.4mm) but with slightly different cup dimensions. Often interchangeable with ISO 1-inch headsets in practice.',
  '{"steerer_od": "25.4mm / 1 inch", "head_tube_id": "30.2mm", "crown_race_od": "26.4mm", "type": "threaded"}',
  ARRAY['Italian 1-inch', 'Italian threaded headset'],
  '1960s', '1990s', 'Italian',
  'https://www.sheldonbrown.com/headsets.html',
  'Often effectively identical to ISO 1-inch. Some Italian headsets use slightly different cup press-fit dimensions but most are interchangeable.'
),
(
  'c0000000-0000-0000-0000-000000000004',
  'French Headset (30.0mm head tube)',
  'headset',
  'Used on French bicycles (Peugeot, Motobécane, Gitane). Head tube ID is 30.0mm — 0.2mm smaller than ISO. The steerer thread pitch is also different: 25.4mm x 1.0mm (metric) vs ISO 25.4mm x 24 TPI. French headsets are NOT interchangeable with ISO.',
  '{"steerer_od": "25.4mm", "head_tube_id": "30.0mm", "steerer_thread_pitch": "1.0mm (metric)", "type": "threaded"}',
  ARRAY['French 30.0mm', 'French threaded headset'],
  '1900s', '1990s', 'French',
  'https://www.sheldonbrown.com/headsets.html',
  'The 0.2mm difference in head tube ID and the metric thread pitch make French headsets incompatible with ISO. NOS French headsets are increasingly scarce.'
);

-- --- Rear Dropout Spacing ---

INSERT INTO standards (id, name, category, description, measurements, aliases, era_start, era_end, region, source_url, source_notes) VALUES
(
  'd0000000-0000-0000-0000-000000000001',
  '120mm Rear Dropout Spacing',
  'hub_spacing',
  'Standard rear spacing for track bikes and single-speed conversions. Also used on some older 5-speed road bikes.',
  '{"spacing": "120mm", "typical_use": "track, single-speed, some vintage 5-speed"}',
  ARRAY['120mm OLD', '120mm rear'],
  '1950s', NULL, 'Universal',
  'https://www.sheldonbrown.com/frame-spacing.html',
  'Track standard. Also used for some early derailleur bikes with narrow freewheel spacing.'
),
(
  'd0000000-0000-0000-0000-000000000002',
  '126mm Rear Dropout Spacing',
  'hub_spacing',
  'Standard for road bikes through the early 1990s, accommodating 5, 6, and 7-speed freewheels and early freehubs. Most vintage road bikes use this spacing.',
  '{"spacing": "126mm", "typical_use": "road bikes 1970s-early 1990s, 5/6/7-speed"}',
  ARRAY['126mm OLD', '126mm rear'],
  '1970s', '1990s', 'Universal',
  'https://www.sheldonbrown.com/frame-spacing.html',
  'The vintage road standard. Frames can often be cold-set to 130mm for modern wheels.'
),
(
  'd0000000-0000-0000-0000-000000000003',
  '130mm Rear Dropout Spacing',
  'hub_spacing',
  'Modern road standard for 8, 9, 10, and 11-speed hubs. Became standard in the early 1990s when 8-speed cassettes needed more width.',
  '{"spacing": "130mm", "typical_use": "modern road bikes, 8-11 speed"}',
  ARRAY['130mm OLD', '130mm rear'],
  '1990s', NULL, 'Universal',
  'https://www.sheldonbrown.com/frame-spacing.html',
  'Current road standard. Steel frames with 126mm spacing can usually be cold-set to 130mm.'
),
(
  'd0000000-0000-0000-0000-000000000004',
  '135mm Rear Dropout Spacing',
  'hub_spacing',
  'Standard for mountain bikes and many hybrid/touring bikes. Wider spacing for the wider cassettes and dish requirements of MTB wheels.',
  '{"spacing": "135mm", "typical_use": "mountain bikes, hybrids, touring"}',
  ARRAY['135mm OLD', '135mm rear'],
  '1980s', NULL, 'Universal',
  'https://www.sheldonbrown.com/frame-spacing.html',
  'MTB standard. Some touring frames also use 135mm for wider tire clearance and disc brake compatibility.'
);

-- --- Seatpost Diameters ---

INSERT INTO standards (id, name, category, description, measurements, aliases, era_start, era_end, region, source_url, source_notes) VALUES
(
  'e0000000-0000-0000-0000-000000000001',
  '25.0mm Seatpost',
  'seatpost',
  'Common on some French bikes (Peugeot) and older lightweight frames.',
  '{"diameter": "25.0mm"}',
  ARRAY['25.0 seatpost'],
  '1960s', '1990s', 'French',
  'https://www.sheldonbrown.com/seatposts.html',
  'Typical of French frames, especially Peugeot.'
),
(
  'e0000000-0000-0000-0000-000000000002',
  '25.4mm Seatpost',
  'seatpost',
  'Common on many older road bikes, especially lower-end models. Also found on some BMX bikes.',
  '{"diameter": "25.4mm / 1 inch"}',
  ARRAY['25.4 seatpost', '1-inch seatpost'],
  '1960s', '1990s', 'Universal',
  'https://www.sheldonbrown.com/seatposts.html',
  'A very common vintage size. Easy to find aftermarket.'
),
(
  'e0000000-0000-0000-0000-000000000003',
  '26.0mm Seatpost',
  'seatpost',
  'Common on Japanese road bikes from the 1970s-1980s (Nishiki, Miyata, Fuji). Also used on many Italian frames.',
  '{"diameter": "26.0mm"}',
  ARRAY['26.0 seatpost'],
  '1960s', '1990s', 'Japanese/Italian',
  'https://www.sheldonbrown.com/seatposts.html',
  'Very common vintage size. Found on most mid-range Japanese road bikes.'
),
(
  'e0000000-0000-0000-0000-000000000004',
  '26.4mm Seatpost',
  'seatpost',
  'Used on some higher-end road frames with thinner-walled seat tubes.',
  '{"diameter": "26.4mm"}',
  ARRAY['26.4 seatpost'],
  '1970s', '1990s', 'Universal',
  'https://www.sheldonbrown.com/seatposts.html',
  'Less common but still encountered on quality vintage frames.'
),
(
  'e0000000-0000-0000-0000-000000000005',
  '26.8mm Seatpost',
  'seatpost',
  'Common on higher-end road bikes, especially Japanese frames with thinner-walled CrMo seat tubes.',
  '{"diameter": "26.8mm"}',
  ARRAY['26.8 seatpost'],
  '1970s', NULL, 'Universal',
  'https://www.sheldonbrown.com/seatposts.html',
  'Very common on quality road frames. Still a standard size for many modern steel frames.'
),
(
  'e0000000-0000-0000-0000-000000000006',
  '27.0mm Seatpost',
  'seatpost',
  'Used on many older European and Japanese road bikes.',
  '{"diameter": "27.0mm"}',
  ARRAY['27.0 seatpost'],
  '1970s', '1990s', 'Universal',
  'https://www.sheldonbrown.com/seatposts.html',
  'Found on a range of vintage frames. Shims are available to adapt between nearby sizes.'
),
(
  'e0000000-0000-0000-0000-000000000007',
  '27.2mm Seatpost',
  'seatpost',
  'The most common modern seatpost diameter. Standard on most current road and many mountain bike frames.',
  '{"diameter": "27.2mm"}',
  ARRAY['27.2 seatpost'],
  '1980s', NULL, 'Universal',
  'https://www.sheldonbrown.com/seatposts.html',
  'The modern standard. Widest selection of available posts.'
);

-- --- Stem Quill Sizes ---

INSERT INTO standards (id, name, category, description, measurements, aliases, era_start, era_end, region, source_url, source_notes) VALUES
(
  'f0000000-0000-0000-0000-000000000001',
  '22.2mm Quill Stem (ISO)',
  'stem',
  'Standard quill stem diameter for 1-inch threaded steerer tubes. The quill (the part that inserts into the steerer) is 22.2mm in diameter. Used on all ISO/English/Japanese bikes with 1-inch headsets.',
  '{"quill_diameter": "22.2mm", "steerer_standard": "ISO 1-inch"}',
  ARRAY['22.2 quill', 'ISO quill', 'standard quill'],
  '1960s', NULL, 'Universal',
  'https://www.sheldonbrown.com/handbars.html',
  'Standard size. Must not be confused with French 22.0mm stems.'
),
(
  'f0000000-0000-0000-0000-000000000002',
  '22.0mm Quill Stem (French)',
  'stem',
  'French-specific quill stem diameter. 0.2mm smaller than ISO. Used on French bikes with French-threaded headsets (Peugeot, Motobécane, Gitane). An ISO stem will not fit in a French steerer tube.',
  '{"quill_diameter": "22.0mm", "steerer_standard": "French"}',
  ARRAY['22.0 quill', 'French quill'],
  '1900s', '1990s', 'French',
  'https://www.sheldonbrown.com/handbars.html',
  'The 0.2mm difference matters. ISO stems will not fit French steerer tubes. French stems are increasingly rare.'
);

-- --- Handlebar Clamp Diameters ---

INSERT INTO standards (id, name, category, description, measurements, aliases, era_start, era_end, region, source_url, source_notes) VALUES
(
  'f1000000-0000-0000-0000-000000000001',
  '25.4mm Handlebar Clamp (ISO)',
  'handlebar',
  'Standard handlebar clamp diameter for most quill stems. The center section of the handlebar where it meets the stem is 25.4mm (1 inch). Used on nearly all non-Italian road bikes and most flat-bar bikes.',
  '{"clamp_diameter": "25.4mm / 1 inch"}',
  ARRAY['25.4 clamp', '1-inch bar clamp', 'ISO bar clamp'],
  '1960s', NULL, 'Universal',
  'https://www.sheldonbrown.com/handbars.html',
  'Standard for most vintage road bikes. Not compatible with Italian 26.0mm stems without shimming.'
),
(
  'f1000000-0000-0000-0000-000000000002',
  '26.0mm Handlebar Clamp (Italian)',
  'handlebar',
  'Italian handlebar clamp diameter. 0.6mm larger than ISO. Used on Italian stems (Cinelli, ITM, 3ttt) and requires matching Italian handlebars. Common on Italian racing bikes.',
  '{"clamp_diameter": "26.0mm"}',
  ARRAY['26.0 clamp', 'Italian bar clamp'],
  '1960s', '2000s', 'Italian',
  'https://www.sheldonbrown.com/handbars.html',
  'Cinelli, ITM, and 3ttt stems typically use 26.0mm clamp. A 25.4mm bar will be loose in a 26.0mm stem.'
);

-- --- Wheel/Tire Sizing ---

INSERT INTO standards (id, name, category, description, measurements, aliases, era_start, era_end, region, source_url, source_notes) VALUES
(
  'g0000000-0000-0000-0000-000000000001',
  '700c / 622mm (ISO) Wheel',
  'wheel_size',
  'The modern road bike wheel standard. ISO bead seat diameter of 622mm. Called "700c" from the old French system where "700" was the approximate outer diameter and "c" was a width designation. Also used for cyclocross, gravel, and many hybrid bikes.',
  '{"iso_bsd": "622mm", "french_designation": "700c", "etrto_example": "23-622 (700x23c)"}',
  ARRAY['700c', '622', '28 inch (European)', '29er (with wide tires)'],
  '1960s', NULL, 'Universal',
  'https://www.sheldonbrown.com/tire-sizing.html',
  '29er mountain bike wheels are the same 622mm BSD as 700c, just with wider rims and tires.'
),
(
  'g0000000-0000-0000-0000-000000000002',
  '27 inch / 630mm (ISO) Wheel',
  'wheel_size',
  'The old road bike standard, common on American and Japanese bikes through the 1980s. ISO bead seat diameter of 630mm — 8mm larger than 700c. 27" tires will NOT fit 700c rims and vice versa.',
  '{"iso_bsd": "630mm", "common_tire_sizes": "27 x 1-1/4, 27 x 1-1/8, 27 x 1"}',
  ARRAY['27 inch', '630'],
  '1960s', '1990s', 'American/Japanese',
  'https://www.sheldonbrown.com/tire-sizing.html',
  'NOT the same as 700c despite similar appearance. The 8mm BSD difference means tires and rims are not interchangeable. 27" tire selection is shrinking.'
),
(
  'g0000000-0000-0000-0000-000000000003',
  '650b / 584mm (ISO) Wheel',
  'wheel_size',
  'Originally a French standard for randonneuring and touring bikes, revived in the 2010s for gravel and mountain bikes. ISO bead seat diameter of 584mm. Also marketed as "27.5 inch" for mountain bikes.',
  '{"iso_bsd": "584mm", "french_designation": "650b", "mtb_designation": "27.5 inch"}',
  ARRAY['650b', '584', '27.5 inch', '650b x 38', '650b x 42'],
  '1940s', NULL, 'French/Universal',
  'https://www.sheldonbrown.com/tire-sizing.html',
  'Classic randonneur size experiencing a renaissance. Same rim as 27.5" MTB wheels.'
),
(
  'g0000000-0000-0000-0000-000000000004',
  '26 inch / 559mm (ISO) Wheel',
  'wheel_size',
  'The classic mountain bike wheel size. ISO bead seat diameter of 559mm. Standard for MTBs from the 1980s through the 2010s. Also used on many touring and utility bikes worldwide.',
  '{"iso_bsd": "559mm", "common_tire_sizes": "26 x 1.5, 26 x 1.75, 26 x 2.0, 26 x 2.1"}',
  ARRAY['26 inch MTB', '559', '26 x 1.95', '26 x 2.1'],
  '1980s', NULL, 'Universal',
  'https://www.sheldonbrown.com/tire-sizing.html',
  'Note: "26 inch" in the fractional sizing system (26 x 1-3/8) is a DIFFERENT size (590mm BSD). Always verify BSD.'
);

-- --- Freewheel vs Freehub ---

INSERT INTO standards (id, name, category, description, measurements, aliases, era_start, era_end, region, source_url, source_notes) VALUES
(
  'h0000000-0000-0000-0000-000000000001',
  'Threaded Freewheel Hub',
  'drivetrain',
  'Older hub design where the freewheel mechanism (ratchet + cogs) threads onto the hub body. Standard thread is 1.370" x 24 TPI (same as English BB!). Available in 5, 6, and 7-speed configurations. The freewheel contains its own bearings.',
  '{"thread": "1.370 x 24 TPI", "speeds": "5, 6, 7", "attachment": "threaded"}',
  ARRAY['freewheel', 'screw-on freewheel', 'threaded freewheel'],
  '1950s', NULL, 'Universal',
  'https://www.sheldonbrown.com/free-k7.html',
  'Still available and used on budget bikes. Cannot accept cassettes. The small bearing spacing makes the axle prone to bending on the drive side.'
),
(
  'h0000000-0000-0000-0000-000000000002',
  'Freehub (Cassette) Hub',
  'drivetrain',
  'Modern hub design where the ratchet mechanism is built into the hub body and individual cogs (a cassette) slide onto a splined freehub body. Allows for wider bearing spacing and stronger axles. Shimano HG spline is the most common freehub body standard.',
  '{"attachment": "splined freehub body", "speeds": "7-12", "common_spline": "Shimano HG"}',
  ARRAY['freehub', 'cassette hub', 'Hyperglide hub'],
  '1980s', NULL, 'Universal',
  'https://www.sheldonbrown.com/free-k7.html',
  'Modern standard. Freehub bodies come in different spline patterns: Shimano HG, SRAM XD, Campagnolo, and Shimano Micro Spline.'
);

-- --- Friction vs Indexed Shifting ---

INSERT INTO standards (id, name, category, description, measurements, aliases, era_start, era_end, region, source_url, source_notes) VALUES
(
  'i0000000-0000-0000-0000-000000000001',
  'Friction Shifting',
  'shifting',
  'The original derailleur shifting method. The rider moves the shift lever to the desired position by feel, without click stops. Works with any derailleur and any number of cogs. Extremely versatile and forgiving of cable stretch and slight misadjustment.',
  '{"type": "friction", "click_stops": false}',
  ARRAY['friction shift', 'friction shifters', 'non-indexed'],
  '1930s', NULL, 'Universal',
  'https://www.sheldonbrown.com/derailer-adjustment.html',
  'The universal compatibility solution. Friction shifters work with virtually any derailleur and any number of cogs. Preferred by many touring cyclists and vintage enthusiasts for reliability.'
),
(
  'i0000000-0000-0000-0000-000000000002',
  'Indexed Shifting (Shimano SIS)',
  'shifting',
  'Shimano Index System — click-stop shifting where each click moves the derailleur to the next cog. Requires matched shifter, derailleur, and cassette/freewheel with correct cog spacing. Cable pull ratio must match between shifter and derailleur.',
  '{"type": "indexed", "click_stops": true, "system": "Shimano SIS"}',
  ARRAY['indexed', 'SIS', 'click shifting', 'Shimano indexed'],
  '1985', NULL, 'Japanese',
  'https://www.sheldonbrown.com/derailer-adjustment.html',
  'Requires matched components. A 7-speed Shimano shifter must be used with 7-speed Shimano-spaced cogs and a compatible Shimano derailleur. Mixing speeds or brands usually does not work with indexed shifting.'
);


-- ============================================================
-- COMPATIBILITY RULES
-- ============================================================

-- Rule 1: ISO/English BB with JIS Square Taper — direct fit
INSERT INTO compatibility_rules (id, standard_a_id, standard_b_id, compatibility_type, confidence, caveats, source_url, source_notes) VALUES
(
  'r0000000-0000-0000-0000-000000000001',
  'a0000000-0000-0000-0000-000000000001', -- ISO/English BB
  'b0000000-0000-0000-0000-000000000001', -- JIS square taper
  'direct_fit', 'confirmed',
  'Most common combination worldwide. JIS square taper BBs with ISO/English threading are widely available from Shimano, Tange, and others. Choose spindle length to match your crankset.',
  'https://www.sheldonbrown.com/bbsize.html',
  'The default combination for most bikes.'
);

-- Rule 2: Italian BB with ISO Square Taper — direct fit
INSERT INTO compatibility_rules (id, standard_a_id, standard_b_id, compatibility_type, confidence, caveats, source_url, source_notes) VALUES
(
  'r0000000-0000-0000-0000-000000000002',
  'a0000000-0000-0000-0000-000000000002', -- Italian BB
  'b0000000-0000-0000-0000-000000000002', -- ISO square taper
  'direct_fit', 'confirmed',
  'Standard combination for Italian frames with Campagnolo or other European cranksets. Italian-threaded BBs with ISO taper are available from Campagnolo, Miche, and others.',
  'https://www.sheldonbrown.com/bbtaper.html',
  'Traditional Italian racing setup.'
);

-- Rule 3: JIS vs ISO square taper — partial compatibility
INSERT INTO compatibility_rules (id, standard_a_id, standard_b_id, compatibility_type, confidence, caveats, source_url, source_notes) VALUES
(
  'r0000000-0000-0000-0000-000000000003',
  'b0000000-0000-0000-0000-000000000001', -- JIS square taper
  'b0000000-0000-0000-0000-000000000002', -- ISO square taper
  'partial', 'confirmed',
  'JIS cranks on an ISO spindle will sit about 1mm further inboard than intended. ISO cranks on a JIS spindle will sit about 1mm further outboard. This affects chainline. In practice, many riders mix them without issue, but it is technically incorrect and can affect shifting precision on indexed systems.',
  'https://www.sheldonbrown.com/bbtaper.html',
  'The ~1mm difference is usually tolerable but purists and indexed-shifting users should match standards.'
);

-- Rule 4: French BB threading — incompatible with ISO/English
INSERT INTO compatibility_rules (id, standard_a_id, standard_b_id, compatibility_type, confidence, caveats, source_url, source_notes) VALUES
(
  'r0000000-0000-0000-0000-000000000004',
  'a0000000-0000-0000-0000-000000000001', -- ISO/English BB
  'a0000000-0000-0000-0000-000000000003', -- French BB
  'incompatible', 'confirmed',
  'Different thread diameter (34.8mm vs 35mm) and different thread pitch (24 TPI vs 1mm metric). An ISO BB will not thread into a French shell and vice versa. The dimensions are close enough that you might get a thread or two in before it locks up — stop immediately if this happens.',
  'https://www.sheldonbrown.com/cribsheet-threadings.html',
  'A common source of damaged threads on vintage French bikes.'
);

-- Rule 5: French and Swiss BB — partial (same dimensions, different thread direction)
INSERT INTO compatibility_rules (id, standard_a_id, standard_b_id, compatibility_type, confidence, caveats, source_url, source_notes) VALUES
(
  'r0000000-0000-0000-0000-000000000005',
  'a0000000-0000-0000-0000-000000000003', -- French BB
  'a0000000-0000-0000-0000-000000000004', -- Swiss BB
  'partial', 'confirmed',
  'Same thread diameter (35mm) and pitch (1mm) but the drive-side cup threads in opposite directions. The non-drive-side cup threads the same way in both standards (right-hand). You can use a French non-drive cup in a Swiss shell, but NEVER the drive-side cup.',
  'https://www.sheldonbrown.com/cribsheet-threadings.html',
  'Critical to identify correctly — cross-threading will destroy the BB shell.'
);

-- Rule 6: 126mm to 130mm cold set
INSERT INTO compatibility_rules (id, standard_a_id, standard_b_id, compatibility_type, confidence, caveats, source_url, source_notes) VALUES
(
  'r0000000-0000-0000-0000-000000000006',
  'd0000000-0000-0000-0000-000000000002', -- 126mm spacing
  'd0000000-0000-0000-0000-000000000003', -- 130mm spacing
  'with_adapter', 'confirmed',
  'Steel frames can be cold-set (carefully spread) from 126mm to 130mm to accept modern road wheels. This is a well-established technique that does not damage a quality steel frame. Do NOT attempt on aluminum, carbon, or titanium frames. The 4mm total spread (2mm per side) is well within the elastic range of steel.',
  'https://www.sheldonbrown.com/frame-spacing.html',
  'One of the most common vintage bike upgrades. Allows use of modern 8-11 speed wheels in vintage steel frames.'
);

-- Rule 7: 27" to 700c wheel swap
INSERT INTO compatibility_rules (id, standard_a_id, standard_b_id, compatibility_type, confidence, caveats, source_url, source_notes) VALUES
(
  'r0000000-0000-0000-0000-000000000007',
  'g0000000-0000-0000-0000-000000000002', -- 27" wheel
  'g0000000-0000-0000-0000-000000000001', -- 700c wheel
  'with_adapter', 'confirmed',
  'Tires and rims are NOT interchangeable (630mm vs 622mm BSD). However, you can swap 27" wheels for 700c wheels in the same frame — the 700c wheel will be about 4mm smaller in radius, which means the brake pads will need to reach about 4mm lower. Most sidepull brakes can accommodate this with adjustment. Long-reach brakes may be needed on some frames.',
  'https://www.sheldonbrown.com/harris/wheelbuild/tires.html',
  'A very popular upgrade for vintage bikes — gives access to the much wider selection of modern 700c tires.'
);

-- Rule 8: Freewheel hub — incompatible with cassette
INSERT INTO compatibility_rules (id, standard_a_id, standard_b_id, compatibility_type, confidence, caveats, source_url, source_notes) VALUES
(
  'r0000000-0000-0000-0000-000000000008',
  'h0000000-0000-0000-0000-000000000001', -- Threaded freewheel
  'h0000000-0000-0000-0000-000000000002', -- Freehub/cassette
  'incompatible', 'confirmed',
  'A threaded freewheel hub cannot accept a cassette, and a freehub cannot accept a threaded freewheel. They are fundamentally different designs. To switch from freewheel to cassette, you need a new rear wheel (or at minimum a new hub and rebuild). Some freehubs do accept 7-speed cassettes that can work with older shifters.',
  'https://www.sheldonbrown.com/free-k7.html',
  'The most fundamental drivetrain compatibility question for vintage bikes.'
);

-- Rule 9: Friction shifting works with everything
INSERT INTO compatibility_rules (id, standard_a_id, standard_b_id, compatibility_type, confidence, caveats, source_url, source_notes) VALUES
(
  'r0000000-0000-0000-0000-000000000009',
  'i0000000-0000-0000-0000-000000000001', -- Friction shifting
  'h0000000-0000-0000-0000-000000000001', -- Threaded freewheel
  'direct_fit', 'confirmed',
  'Friction shifters work with any freewheel regardless of speed count or cog spacing. This is one of the great advantages of friction shifting — total compatibility with any rear cog setup.',
  'https://www.sheldonbrown.com/derailer-adjustment.html',
  'The universal compatibility solution for rear shifting.'
);

-- Rule 10: Friction shifting with freehub
INSERT INTO compatibility_rules (id, standard_a_id, standard_b_id, compatibility_type, confidence, caveats, source_url, source_notes) VALUES
(
  'r0000000-0000-0000-0000-000000000010',
  'i0000000-0000-0000-0000-000000000001', -- Friction shifting
  'h0000000-0000-0000-0000-000000000002', -- Freehub/cassette
  'direct_fit', 'confirmed',
  'Friction shifters work with any cassette regardless of speed count. Combined with a wide-range rear derailleur, friction shifting can operate 7, 8, 9, 10, or even 11-speed cassettes. Cable pull ratio does not matter because there are no click stops.',
  'https://www.sheldonbrown.com/derailer-adjustment.html',
  'Many touring cyclists use friction shifters with modern cassettes for simplicity and reliability.'
);

-- Rule 11: French headset — incompatible with ISO 1-inch
INSERT INTO compatibility_rules (id, standard_a_id, standard_b_id, compatibility_type, confidence, caveats, source_url, source_notes) VALUES
(
  'r0000000-0000-0000-0000-000000000011',
  'c0000000-0000-0000-0000-000000000001', -- ISO 1-inch headset
  'c0000000-0000-0000-0000-000000000004', -- French headset
  'incompatible', 'confirmed',
  'Despite both using 25.4mm steerer tubes, the head tube bore diameter differs (30.2mm ISO vs 30.0mm French) and the steerer thread pitch differs (24 TPI vs 1.0mm metric). ISO headset cups will not press into a French head tube, and French threading will not mate with ISO threading.',
  'https://www.sheldonbrown.com/headsets.html',
  'The most frustrating French compatibility issue. NOS French headsets are the best solution; some have had success carefully reaming a French head tube to accept ISO cups.'
);

-- Rule 12: Italian headset — compatible with ISO 1-inch
INSERT INTO compatibility_rules (id, standard_a_id, standard_b_id, compatibility_type, confidence, caveats, source_url, source_notes) VALUES
(
  'r0000000-0000-0000-0000-000000000012',
  'c0000000-0000-0000-0000-000000000001', -- ISO 1-inch headset
  'c0000000-0000-0000-0000-000000000003', -- Italian headset
  'direct_fit', 'widely_reported',
  'Italian 1-inch headsets typically have the same dimensions as ISO 1-inch headsets and are interchangeable in practice. The steerer threading is the same (1" x 24 TPI) and the head tube bore is the same (30.2mm). Some very old Italian headsets may have slightly different cup dimensions.',
  'https://www.sheldonbrown.com/headsets.html',
  'Generally interchangeable. Verify cup OD if working with a very old Italian frame.'
);

-- Rule 13: ISO quill stem in French steerer — incompatible
INSERT INTO compatibility_rules (id, standard_a_id, standard_b_id, compatibility_type, confidence, caveats, source_url, source_notes) VALUES
(
  'r0000000-0000-0000-0000-000000000013',
  'f0000000-0000-0000-0000-000000000001', -- 22.2mm ISO quill
  'f0000000-0000-0000-0000-000000000002', -- 22.0mm French quill
  'incompatible', 'confirmed',
  'A 22.2mm ISO quill stem will not fit inside a French steerer tube with its 22.0mm bore. The 0.2mm difference is enough to prevent insertion. A French 22.0mm stem in an ISO steerer will be dangerously loose. Do not shim a French stem for use in an ISO steerer — this is a safety-critical interface.',
  'https://www.sheldonbrown.com/handbars.html',
  'Another French compatibility headache. French quill stems are becoming scarce.'
);

-- Rule 14: 25.4mm bar in 26.0mm stem — with adapter (shim)
INSERT INTO compatibility_rules (id, standard_a_id, standard_b_id, compatibility_type, confidence, caveats, source_url, source_notes) VALUES
(
  'r0000000-0000-0000-0000-000000000014',
  'f1000000-0000-0000-0000-000000000001', -- 25.4mm bar clamp
  'f1000000-0000-0000-0000-000000000002', -- 26.0mm bar clamp
  'with_adapter', 'confirmed',
  'A 25.4mm handlebar can be used in a 26.0mm stem with a 0.6mm shim (a thin piece of aluminum or brass wrapped around the bar center). Shims are commercially available or can be made from a beer/soda can in a pinch. The reverse (26.0mm bar in 25.4mm stem) is not possible without filing the bar.',
  'https://www.sheldonbrown.com/handbars.html',
  'A practical and common solution when mixing Italian and non-Italian components.'
);

-- Rule 15: 700c and 650b — incompatible (different wheel sizes)
INSERT INTO compatibility_rules (id, standard_a_id, standard_b_id, compatibility_type, confidence, caveats, source_url, source_notes) VALUES
(
  'r0000000-0000-0000-0000-000000000015',
  'g0000000-0000-0000-0000-000000000001', -- 700c
  'g0000000-0000-0000-0000-000000000003', -- 650b
  'incompatible', 'confirmed',
  'Different bead seat diameters (622mm vs 584mm). Tires and rims are not interchangeable. However, some frames designed for 700c can also accept 650b wheels with wider tires — the smaller wheel diameter is offset by the larger tire, resulting in a similar overall diameter. This is popular for gravel conversions. Check frame clearance.',
  'https://www.sheldonbrown.com/tire-sizing.html',
  'The 700c-to-650b conversion for wider tires is increasingly popular but requires frame compatibility verification.'
);

-- Rule 16: 120mm to 126mm spacing
INSERT INTO compatibility_rules (id, standard_a_id, standard_b_id, compatibility_type, confidence, caveats, source_url, source_notes) VALUES
(
  'r0000000-0000-0000-0000-000000000016',
  'd0000000-0000-0000-0000-000000000001', -- 120mm spacing
  'd0000000-0000-0000-0000-000000000002', -- 126mm spacing
  'with_adapter', 'confirmed',
  'Steel frames can be cold-set from 120mm to 126mm. The 6mm spread (3mm per side) is manageable for a quality steel frame. This is commonly done when converting a track frame to a geared road bike. Do NOT attempt on aluminum, carbon, or titanium.',
  'https://www.sheldonbrown.com/frame-spacing.html',
  'Common conversion for track frame road builds.'
);

-- Rule 17: Italian BB threading — incompatible with French
INSERT INTO compatibility_rules (id, standard_a_id, standard_b_id, compatibility_type, confidence, caveats, source_url, source_notes) VALUES
(
  'r0000000-0000-0000-0000-000000000017',
  'a0000000-0000-0000-0000-000000000002', -- Italian BB
  'a0000000-0000-0000-0000-000000000003', -- French BB
  'incompatible', 'confirmed',
  'Italian threading is 36mm x 24 TPI; French is 35mm x 1mm. Completely different thread diameter and pitch. Not interchangeable under any circumstances.',
  'https://www.sheldonbrown.com/cribsheet-threadings.html',
  'Different in both diameter and pitch system (imperial vs metric).'
);

-- Rule 18: Seatpost shimming (27.2 to 26.8)
INSERT INTO compatibility_rules (id, standard_a_id, standard_b_id, compatibility_type, confidence, caveats, source_url, source_notes) VALUES
(
  'r0000000-0000-0000-0000-000000000018',
  'e0000000-0000-0000-0000-000000000007', -- 27.2mm seatpost
  'e0000000-0000-0000-0000-000000000005', -- 26.8mm seatpost
  'with_adapter', 'confirmed',
  'A 26.8mm seatpost can be used in a 27.2mm seat tube with a shim. Shims for this size difference (0.4mm / 0.2mm per side) are commercially available. The reverse is not possible — a 27.2mm post will not fit in a 26.8mm tube. Always use a proper shim, not tape or other makeshift solutions.',
  'https://www.sheldonbrown.com/seatposts.html',
  'Shimming down is common and safe. Going more than 1-2mm difference is not recommended.'
);


-- ============================================================
-- MEASUREMENT CONVERSIONS
-- ============================================================

INSERT INTO measurement_conversions (category, value_a, value_b, system_a, system_b, notes, source_url) VALUES
-- Wheel/tire size conversions
('wheel_size', '700c', '622mm BSD (ISO)', 'French', 'ISO', 'The "c" originally indicated width class but is now meaningless — 700c is simply 622mm BSD', 'https://www.sheldonbrown.com/tire-sizing.html'),
('wheel_size', '700 x 23c', '23-622 (ETRTO)', 'French', 'ETRTO', '23mm tire width on 622mm bead seat diameter', 'https://www.sheldonbrown.com/tire-sizing.html'),
('wheel_size', '700 x 25c', '25-622 (ETRTO)', 'French', 'ETRTO', '25mm tire width on 622mm bead seat diameter', 'https://www.sheldonbrown.com/tire-sizing.html'),
('wheel_size', '700 x 28c', '28-622 (ETRTO)', 'French', 'ETRTO', '28mm tire width on 622mm bead seat diameter', 'https://www.sheldonbrown.com/tire-sizing.html'),
('wheel_size', '700 x 32c', '32-622 (ETRTO)', 'French', 'ETRTO', '32mm tire width on 622mm bead seat diameter', 'https://www.sheldonbrown.com/tire-sizing.html'),
('wheel_size', '27 x 1-1/4', '32-630 (ETRTO)', 'Imperial', 'ETRTO', 'Common tire on vintage road bikes. NOT compatible with 700c rims.', 'https://www.sheldonbrown.com/tire-sizing.html'),
('wheel_size', '27 x 1-1/8', '28-630 (ETRTO)', 'Imperial', 'ETRTO', 'Narrower 27" tire. NOT compatible with 700c rims.', 'https://www.sheldonbrown.com/tire-sizing.html'),
('wheel_size', '650b', '584mm BSD (ISO)', 'French', 'ISO', 'Same as 27.5" MTB wheels', 'https://www.sheldonbrown.com/tire-sizing.html'),
('wheel_size', '650b x 38', '38-584 (ETRTO)', 'French', 'ETRTO', 'Classic randonneur tire size', 'https://www.sheldonbrown.com/tire-sizing.html'),
('wheel_size', '26 x 1.95', '49-559 (ETRTO)', 'Imperial', 'ETRTO', 'Common MTB tire. 559mm BSD.', 'https://www.sheldonbrown.com/tire-sizing.html'),
('wheel_size', '26 x 2.1', '54-559 (ETRTO)', 'Imperial', 'ETRTO', 'Wider MTB tire. 559mm BSD.', 'https://www.sheldonbrown.com/tire-sizing.html'),
('wheel_size', '26 x 1-3/8', '37-590 (ETRTO)', 'Imperial', 'ETRTO', 'WARNING: 590mm BSD — NOT the same as 26" MTB (559mm). Used on some English 3-speeds.', 'https://www.sheldonbrown.com/tire-sizing.html'),

-- Seatpost diameter conversions
('seatpost_diameter', '25.0mm', '0.984 inches', 'Metric', 'Imperial', 'Common on French bikes (Peugeot)', 'https://www.sheldonbrown.com/seatposts.html'),
('seatpost_diameter', '25.4mm', '1.000 inches', 'Metric', 'Imperial', 'Exactly 1 inch', 'https://www.sheldonbrown.com/seatposts.html'),
('seatpost_diameter', '26.8mm', '1.055 inches', 'Metric', 'Imperial', 'Common on quality road frames', 'https://www.sheldonbrown.com/seatposts.html'),
('seatpost_diameter', '27.2mm', '1.071 inches', 'Metric', 'Imperial', 'Modern standard', 'https://www.sheldonbrown.com/seatposts.html'),

-- BB threading conversions
('bb_threading', '1.370" x 24 TPI', '34.8mm x 24 TPI', 'Imperial', 'Metric', 'ISO/English/BSC bottom bracket threading', 'https://www.sheldonbrown.com/cribsheet-threadings.html'),
('bb_threading', 'M36 x 24 TPI', '36mm x 24 TPI', 'ISO', 'Metric', 'Italian bottom bracket threading', 'https://www.sheldonbrown.com/cribsheet-threadings.html'),
('bb_threading', 'M35 x 1mm', '35mm x 1mm pitch', 'ISO', 'Metric', 'French (and Swiss) bottom bracket threading', 'https://www.sheldonbrown.com/cribsheet-threadings.html'),

-- Headset size conversions
('headset_size', '1 inch', '25.4mm steerer / 30.2mm head tube', 'Imperial', 'Metric', 'ISO/JIS 1-inch threaded headset dimensions', 'https://www.sheldonbrown.com/headsets.html'),
('headset_size', '1-1/8 inch', '28.6mm steerer / 34.0mm head tube', 'Imperial', 'Metric', 'Modern threadless headset dimensions', 'https://www.sheldonbrown.com/headsets.html');
