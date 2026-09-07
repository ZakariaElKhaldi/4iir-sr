# Report diagram sources

These files are editable diagram sources derived from the implemented repository:

- `01-use-cases.mmd`: actors and supported system interactions;
- `02-ingestion-sequence.mmd`: durable ingestion and publication sequence;
- `03-domain-classes.mmd`: operational detection entities and multiplicities;
- `03b-ingestion-classes.mmd`: durable-ingestion and outbox persistence model;
- `03c-model-health-classes.mmd`: model-health snapshot and JSON value objects;
- `03d-service-operations.mmd`: implemented service operations and dependencies;
- `04-ingestion-states.mmd`: implemented ingestion-job lifecycle;
- `05-project-timeline.mmd`: indicative overlapping phases, following the author's account;
- `06-authentication-sequence.mmd`: login, throttling, and token validation;
- `07-synchronous-prediction-sequence.mmd`: synchronous cascade inference;
- `08-dataset-replay-sequence.mmd`: bounded dataset replay and controls;
- `09-alert-investigation-sequence.mmd`: alert review, explanation, and feedback;
- `10-suricata-sensor-sequence.mmd`: signature-event ingestion from an external network;
- `11-model-health-sequence.mmd`: scheduled shadow-mode model-health evaluation;
- `12-operator-activity.mmd`: operator activity across monitoring, investigation, and flow testing;
- `13-alert-communication.mmd`: numbered object communication during alert investigation;
- `14-component-architecture.mmd`: implemented software components and interfaces;
- `15-docker-deployment.mmd`: Docker demonstration nodes and communication paths; and
- `16-relational-core.mmd`: keys and relationships in the persisted detection core.

The authentication, dataset-replay, and Suricata sequence sources remain as
engineering references, but are intentionally excluded from the report. Their
interaction mechanics are already covered by the use-case descriptions and the
retained prediction or durable-ingestion sequences.

The relational-core diagram (`16-relational-core.mmd`) remains an engineering
reference for the concise relational-model and data-dictionary sections in the
report.

The report-facing sources are generated from the Mermaid files listed above,
with one supplied vector exception:

- `uscase_diagrame.svg` is the exact use-case artwork embedded by the report
  after lossless vector conversion to PDF; and
- the remaining report diagrams are rendered from their authoritative `.mmd`
  sources by Mermaid CLI 11.16.1.

All Mermaid report figures share `report-mermaid-config.json`, which applies the
report's emerald, ivory, charcoal, and muted-ink palette consistently. Pale gold
is reserved for warning and explanatory notes.

The report uses Mermaid's adaptive ELK layout for the layouts that need
collision-aware routing at A4 size:

- `04-ingestion-states.mmd`: ingestion state machine; and
- `15-docker-deployment.mmd`: Docker deployment topology.

They are rendered directly to fitted vector PDFs by the pinned Mermaid CLI
11.16.1 container. ELK assigns layers, ports, and routing lanes together, so
cyclic transitions remain separate without manual coordinates.
The component diagram (`14-component-architecture.mmd`) uses the same ELK workflow. The
retrospective timeline is drawn directly with `pgfgantt` in Chapter~1 so its
labels and weekly ticks follow the report typography. Its S1–S5 bands are
indicative phases, not exact dates inferred from Git. Dashboard development
overlaps research and continues through integration and interface refinement.

## Notation and scope

The UML diagrams follow the normative [OMG UML 2.5.1
specification](https://www.omg.org/spec/UML/2.5.1/PDF). Their Mermaid syntax follows
the official documentation for [sequence
diagrams](https://mermaid.js.org/syntax/sequenceDiagram.html), [class
diagrams](https://mermaid.js.org/syntax/classDiagram.html), and [state
diagrams](https://mermaid.js.org/syntax/stateDiagram.html).

The revisions apply the following rules:

- actors remain outside the system boundary and use cases describe actor goals;
- `extend` points from optional behavior to its base use case and carries a guard;
- sequence diagrams use solid arrows for calls, dashed arrows for replies, open
  arrows for asynchronous broadcasts, balanced execution specifications, and
  UML combined fragments for alternatives, options, loops, and concurrency;
- class attributes use `name: Type`, optionality is explicit, relationships state
  multiplicities, and unrelated concerns are split into separate diagrams; and
- state transitions use `trigger [guard] / effect`, with a choice pseudostate for
  mutually exclusive failure outcomes.

Domain attributes deliberately omit visibility markers: these figures model
persisted data, not Python access modifiers. Public service operations retain
`+`. Neither `+` nor `-` in a diagram establishes API authorization; the backend
enforces authentication and access controls independently.

Mermaid does not implement a native UML use-case diagram. Consequently,
`01-use-cases.mmd` is a carefully styled approximation for Mermaid-only workflows,
and `01-use-cases.puml` remains an editable UML alternative. The report itself
uses `uscase_diagrame.svg` exactly as supplied.

## Reproducible report render

Docker and `rsvg-convert` (from librsvg) are the local prerequisites for the
report-facing use-case and operator-activity figures. From the repository root,
run:

```bash
make report-diagrams
```

The command validates the Mermaid source, converts `uscase_diagrame.svg`
directly to vector PDF with `rsvg-convert`, and renders the activity PDF with
the pinned official Mermaid CLI container. Override `MERMAID_IMAGE` only when
intentionally testing a renderer upgrade; committed outputs must use the pinned
default in `render-report-diagrams.sh`.

Paste a file into the Mermaid Live Editor, or convert it locally after installing
Mermaid CLI:

```bash
mmdc -i 02-ingestion-sequence.mmd \
  -o rendered/02-ingestion-sequence.pdf \
  -b transparent --pdfFit
```

Validate every Mermaid source with Mermaid CLI 11 or newer:

```bash
mkdir -p rendered
for diagram in *.mmd; do
  mmdc -i "$diagram" \
    -o "rendered/${diagram%.mmd}.pdf" \
    -b transparent --pdfFit
done
```

PDF or SVG is preferable to PNG for inclusion in LaTeX because text and lines
remain sharp when scaled.

## Report-ready exports

The sequence sources use compact Mermaid spacing and omit mirrored participant
boxes. They intentionally show domain-level interactions rather than every
method call; the repository code and architecture documentation remain the
detailed implementation reference.

Tightly fitted vector PDF exports are available in `rendered/`. The `--pdfFit`
flag is required; without it, Mermaid places the chart on a Letter page with
large empty margins. Include the fitted PDF without distortion and cap both
dimensions so it cannot overflow the text area:

```latex
\begin{figure}[htbp]
  \centering
  \includegraphics[
    width=\linewidth,
    height=.72\textheight,
    keepaspectratio
  ]{../diagrams/rendered/02-ingestion-sequence.pdf}
  \caption{Durable ingestion and asynchronous publication.}
\end{figure}
```

Do not convert these PDFs to screenshots or JPEG. For an unusually wide class
diagram, use a landscape figure page instead of reducing the text below a
readable size.
