import Link from "next/link";

export function Header() {
  return (
    <header className="border-b border-[var(--color-border)] bg-[var(--color-surface)]">
      <div className="max-w-5xl mx-auto px-4 py-4 flex items-center justify-between">
        <Link href="/" className="no-underline">
          <h1 className="text-lg font-semibold tracking-tight text-[var(--color-foreground)]">
            BikePartDB
          </h1>
        </Link>
        <nav className="flex gap-6 text-sm">
          <Link
            href="/compatibility"
            className="text-[var(--color-muted)] hover:text-[var(--color-foreground)] transition-colors no-underline"
          >
            Compatibility
          </Link>
          <Link
            href="/standards"
            className="text-[var(--color-muted)] hover:text-[var(--color-foreground)] transition-colors no-underline"
          >
            Standards
          </Link>
          <Link
            href="/converter"
            className="text-[var(--color-muted)] hover:text-[var(--color-foreground)] transition-colors no-underline"
          >
            Converter
          </Link>
        </nav>
      </div>
    </header>
  );
}
