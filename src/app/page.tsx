import Link from "next/link";

export default function Home() {
  return (
    <div className="space-y-12">
      <section className="space-y-4">
        <h2 className="text-2xl font-semibold tracking-tight">
          Will this part work with my bike?
        </h2>
        <p className="text-[var(--color-muted)] max-w-2xl leading-relaxed font-[family-name:var(--font-serif)]">
          A compatibility reference for vintage and modern bicycle parts.
          Threading standards, spindle tapers, dropout spacing, wheel sizes, and
          the caveats that make the difference between a clean build and a
          stripped thread.
        </p>
      </section>

      <div className="grid gap-4 sm:grid-cols-3">
        <Link href="/compatibility" className="no-underline">
          <div className="border border-[var(--color-border)] rounded-lg p-5 hover:bg-[var(--color-surface-hover)] transition-colors bg-[var(--color-surface)]">
            <h3 className="font-semibold mb-2">Compatibility Checker</h3>
            <p className="text-sm text-[var(--color-muted)] leading-relaxed">
              Check if two standards are compatible. Get adapter requirements,
              caveats, and source citations.
            </p>
          </div>
        </Link>

        <Link href="/standards" className="no-underline">
          <div className="border border-[var(--color-border)] rounded-lg p-5 hover:bg-[var(--color-surface-hover)] transition-colors bg-[var(--color-surface)]">
            <h3 className="font-semibold mb-2">Browse Standards</h3>
            <p className="text-sm text-[var(--color-muted)] leading-relaxed">
              Explore interface standards by category &mdash; bottom brackets,
              headsets, hubs, seatposts, and more.
            </p>
          </div>
        </Link>

        <Link href="/converter" className="no-underline">
          <div className="border border-[var(--color-border)] rounded-lg p-5 hover:bg-[var(--color-surface-hover)] transition-colors bg-[var(--color-surface)]">
            <h3 className="font-semibold mb-2">Measurement Converter</h3>
            <p className="text-sm text-[var(--color-muted)] leading-relaxed">
              Convert between metric, imperial, French, and Italian measurement
              systems for bike parts.
            </p>
          </div>
        </Link>
      </div>

      <section className="border-t border-[var(--color-border)] pt-8 space-y-3">
        <h3 className="text-sm font-semibold uppercase tracking-wide text-[var(--color-muted)]">
          Common questions
        </h3>
        <ul className="space-y-2 text-sm font-[family-name:var(--font-serif)]">
          <li className="text-[var(--color-muted)]">
            Can I put a modern cassette hub wheel on my vintage road bike?
          </li>
          <li className="text-[var(--color-muted)]">
            Will a 700c wheel fit where my 27&quot; wheel was?
          </li>
          <li className="text-[var(--color-muted)]">
            Is my French bottom bracket compatible with anything?
          </li>
          <li className="text-[var(--color-muted)]">
            What&apos;s the difference between JIS and ISO square taper?
          </li>
          <li className="text-[var(--color-muted)]">
            Can I cold-set my steel frame for wider hub spacing?
          </li>
        </ul>
      </section>
    </div>
  );
}
