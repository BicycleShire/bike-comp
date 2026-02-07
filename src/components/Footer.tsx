export function Footer() {
  return (
    <footer className="border-t border-[var(--color-border)] bg-[var(--color-surface)] mt-auto">
      <div className="max-w-5xl mx-auto px-4 py-6 text-sm text-[var(--color-muted)]">
        <div className="flex flex-col sm:flex-row justify-between gap-4">
          <div>
            <p>
              Compatibility data sourced from{" "}
              <a
                href="https://www.sheldonbrown.com"
                target="_blank"
                rel="noopener noreferrer"
                className="underline hover:text-[var(--color-foreground)]"
              >
                Sheldon Brown
              </a>{" "}
              and the cycling community.
            </p>
          </div>
          <div className="flex gap-4">
            <a
              href="https://github.com/BicycleShire/bike-comp"
              target="_blank"
              rel="noopener noreferrer"
              className="underline hover:text-[var(--color-foreground)]"
            >
              GitHub
            </a>
          </div>
        </div>
      </div>
    </footer>
  );
}
