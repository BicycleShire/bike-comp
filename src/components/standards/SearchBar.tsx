export function SearchBar({
  category,
  query,
}: {
  category?: string;
  query?: string;
}) {
  return (
    <form action="/standards" method="get" className="flex gap-3">
      {category && <input type="hidden" name="category" value={category} />}
      <input
        type="text"
        name="q"
        defaultValue={query}
        placeholder="Search standards by name or description…"
        className="flex-1 border border-[var(--color-border)] rounded-lg px-4 py-2 text-sm bg-[var(--color-surface)] placeholder:text-[var(--color-muted)] focus:outline-none focus:border-[var(--color-accent)]"
      />
      <button
        type="submit"
        className="px-4 py-2 text-sm font-medium rounded-lg bg-[var(--color-accent)] text-white hover:opacity-90 transition-opacity"
      >
        Search
      </button>
    </form>
  );
}
