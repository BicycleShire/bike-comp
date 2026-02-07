import Link from "next/link";
import type { Standard } from "@/lib/supabase/types";

export function StandardPicker({
  standards,
  category,
  selectedId,
}: {
  standards: Standard[];
  category: string;
  selectedId?: string;
}) {
  if (standards.length === 0) {
    return (
      <p className="text-sm text-[var(--color-muted)]">
        No standards found in this category.
      </p>
    );
  }

  return (
    <div className="grid grid-cols-1 gap-3">
      {standards.map((std) => {
        const isSelected = std.id === selectedId;
        return (
          <Link
            key={std.id}
            href={
              isSelected
                ? `/compatibility?category=${category}`
                : `/compatibility?category=${category}&standard=${std.id}`
            }
            className={`block border rounded-lg p-5 transition-colors no-underline ${
              isSelected
                ? "border-[var(--color-accent)] bg-[var(--color-accent-light)]"
                : "border-[var(--color-border)] bg-[var(--color-surface)] hover:bg-[var(--color-surface-hover)]"
            }`}
          >
            <h3 className="text-sm font-semibold">{std.name}</h3>
            <p className="text-xs text-[var(--color-muted)] mt-1 font-[family-name:var(--font-serif)] line-clamp-2">
              {std.description}
            </p>
            {std.era_start && (
              <p className="text-xs text-[var(--color-muted)] mt-2">
                {std.era_start}
                {std.era_end ? ` – ${std.era_end}` : " – present"} · {std.region}
              </p>
            )}
          </Link>
        );
      })}
    </div>
  );
}
