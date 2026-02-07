const BADGE_STYLES: Record<string, { bg: string; text: string; label: string }> = {
  direct_fit: {
    bg: "bg-[var(--color-accent-light)]",
    text: "text-[var(--color-accent)]",
    label: "Direct Fit",
  },
  with_adapter: {
    bg: "bg-[var(--color-warning-light)]",
    text: "text-[var(--color-warning)]",
    label: "With Adapter",
  },
  partial: {
    bg: "bg-amber-50",
    text: "text-amber-700",
    label: "Partial",
  },
  incompatible: {
    bg: "bg-[var(--color-danger-light)]",
    text: "text-[var(--color-danger)]",
    label: "Incompatible",
  },
};

export function CompatibilityBadge({ type }: { type: string }) {
  const style = BADGE_STYLES[type] ?? {
    bg: "bg-gray-100",
    text: "text-gray-600",
    label: type,
  };

  return (
    <span
      className={`inline-block px-2.5 py-0.5 rounded-full text-xs font-medium ${style.bg} ${style.text}`}
    >
      {style.label}
    </span>
  );
}
