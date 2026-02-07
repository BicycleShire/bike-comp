import Link from "next/link";
import type { Standard } from "@/lib/supabase/types";
import type { Json } from "@/lib/supabase/types";

function renderMeasurements(measurements: Json | null) {
  if (!measurements || typeof measurements !== "object" || Array.isArray(measurements)) {
    return null;
  }
  const entries = Object.entries(measurements as Record<string, Json>);
  if (entries.length === 0) return null;

  return (
    <dl className="grid grid-cols-[auto_1fr] gap-x-3 gap-y-0.5 text-xs">
      {entries.map(([key, value]) => (
        <div key={key} className="contents">
          <dt className="text-[var(--color-muted)]">{key}</dt>
          <dd className="font-mono">{String(value)}</dd>
        </div>
      ))}
    </dl>
  );
}

export function StandardCard({ standard }: { standard: Standard }) {
  const eraText = [standard.era_start, standard.era_end]
    .filter(Boolean)
    .join("–");
  const metaLine = [eraText, standard.region].filter(Boolean).join(" · ");

  return (
    <div className="border border-[var(--color-border)] rounded-lg p-5 bg-[var(--color-surface)] space-y-3">
      <div>
        <h3 className="text-base font-semibold">{standard.name}</h3>
        <p className="text-sm text-[var(--color-muted)] mt-1 font-[family-name:var(--font-serif)]">
          {standard.description}
        </p>
      </div>

      {standard.aliases && standard.aliases.length > 0 && (
        <p className="text-xs text-[var(--color-muted)]">
          <span className="font-medium text-[var(--color-foreground)]">
            Also known as:
          </span>{" "}
          {standard.aliases.join(", ")}
        </p>
      )}

      {metaLine && (
        <p className="text-xs text-[var(--color-muted)]">{metaLine}</p>
      )}

      {renderMeasurements(standard.measurements)}

      <div className="flex items-center gap-4 pt-1 text-xs">
        <Link
          href={`/compatibility?category=${standard.category}&standard=${standard.id}`}
          className="text-[var(--color-accent)] font-medium"
        >
          Check compatibility &rarr;
        </Link>
        {standard.source_url && (
          <a
            href={standard.source_url}
            target="_blank"
            rel="noopener noreferrer"
            className="text-[var(--color-muted)]"
          >
            Source
          </a>
        )}
      </div>
    </div>
  );
}
