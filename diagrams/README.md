# Mermaid diagram sources

These files are editable diagram sources derived from the implemented repository:

- `01-use-cases.mmd`: actors and supported system interactions;
- `02-ingestion-sequence.mmd`: durable ingestion and publication sequence;
- `03-domain-classes.mmd`: operational detection entities and multiplicities;
- `03b-ingestion-classes.mmd`: durable-ingestion and outbox persistence model;
- `03c-model-health-classes.mmd`: model-health snapshot and JSON value objects;
- `04-ingestion-states.mmd`: implemented ingestion-job lifecycle;
- `05-project-timeline.mmd`: timeline reconstructed from Git commit dates;
- `06-authentication-sequence.mmd`: login, throttling, and token validation;
- `07-synchronous-prediction-sequence.mmd`: synchronous cascade inference;
- `08-dataset-replay-sequence.mmd`: bounded dataset replay and controls;
- `09-alert-investigation-sequence.mmd`: alert review, explanation, and feedback;
- `10-suricata-sensor-sequence.mmd`: signature-event ingestion from an external network; and
- `11-model-health-sequence.mmd`: scheduled shadow-mode model-health evaluation.

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

Mermaid does not implement a native UML use-case diagram. Consequently,
`01-use-cases.mmd` is a carefully styled approximation for Mermaid-only workflows,
while `01-use-cases.puml` is the canonical UML version with actor and use-case
notation. Authentication is modeled as its own actor goal; a valid token is a
precondition for protected use cases rather than an incorrect universal
`include` relationship.

Paste a file into the Mermaid Live Editor, or convert it locally after installing
Mermaid CLI:

```bash
mmdc -i 02-ingestion-sequence.mmd -o 02-ingestion-sequence.pdf -b transparent
```

Validate every Mermaid source with Mermaid CLI 11 or newer:

```bash
for diagram in *.mmd; do
  mmdc -i "$diagram" -o "${diagram%.mmd}.svg" -b transparent
done
```

PDF or SVG is preferable to PNG for inclusion in LaTeX because text and lines
remain sharp when scaled.

## Report-ready exports

The sequence sources use compact Mermaid spacing and omit mirrored participant
boxes. They intentionally show domain-level interactions rather than every
method call; the repository code and architecture documentation remain the
detailed implementation reference.

Vector PDF exports are available in `rendered/`. Include them without distortion
and cap both dimensions so a diagram cannot overflow the text area:

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
