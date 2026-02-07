export default function ConverterPage() {
  return (
    <div className="space-y-6">
      <div>
        <h2 className="text-2xl font-semibold tracking-tight">
          Measurement Converter
        </h2>
        <p className="text-[var(--color-muted)] mt-2 font-[family-name:var(--font-serif)]">
          Convert between metric, imperial, French, and Italian measurement
          systems.
        </p>
      </div>

      <div className="border border-dashed border-[var(--color-border)] rounded-lg p-8 text-center text-[var(--color-muted)] text-sm">
        Coming in Phase 1D &mdash; select a measurement category and convert
        between sizing systems.
      </div>
    </div>
  );
}
