import Link from "next/link";
import { CATEGORIES } from "@/lib/constants";

export function CategoryPicker({ selected }: { selected?: string }) {
  return (
    <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
      {CATEGORIES.map((cat) => {
        const isSelected = cat.slug === selected;
        return (
          <Link
            key={cat.slug}
            href={
              isSelected ? "/compatibility" : `/compatibility?category=${cat.slug}`
            }
            className={`block border rounded-lg p-5 transition-colors no-underline ${
              isSelected
                ? "border-[var(--color-accent)] bg-[var(--color-accent-light)]"
                : "border-[var(--color-border)] bg-[var(--color-surface)] hover:bg-[var(--color-surface-hover)]"
            }`}
          >
            <h3 className="text-sm font-semibold">{cat.label}</h3>
            <p className="text-xs text-[var(--color-muted)] mt-1 font-[family-name:var(--font-serif)]">
              {cat.description}
            </p>
          </Link>
        );
      })}
    </div>
  );
}
