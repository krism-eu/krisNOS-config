# krisNCC configuration sync model

## Invariants

1. Sync is user initiated only.
2. Fetch/sync never implies apply.
3. Apply requires a clean working tree.
4. Diverged histories stop and require manual resolution.
5. Pull is fast-forward only.
6. No force push/reset/automatic merge.
7. Validate and build happen before switch.
8. GitHub unavailability must never affect boot or normal desktop operation.

## Intended krisNCC flow

```text
Status / Controlla
        |
        v
Fetch metadata
        |
        v
Mostra diff
        |
        v
[Sincronizza]   <-- explicit user action
        |
        v
local working tree
        |
        +--> [Valida]
        +--> [Costruisci]
        +--> [Applica]   <-- separate explicit action
```

`kris-configctl` in the krisNOS repository is the backend contract for this flow.
