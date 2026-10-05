# krisNOS-config

Configurazione personale di krisNOS.

Questo repository descrive **la macchina e le preferenze personali**; il framework, i moduli di sistema e il codice di krisNCC vivono in [`krism-eu/krisNOS`](https://github.com/krism-eu/krisNOS).

## Collegamento

`flake.nix` importa `krisNOS` come input GitHub e usa il modulo `krisNOS.nixosModules.krisos`. La dipendenza è volutamente unidirezionale:

```text
krisNOS-config  --->  krisNOS
config personale      framework/moduli/krisNCC
```

`krisNOS` non dipende da questo repository.

## Sync

La sincronizzazione è **sempre manuale**. krisNCC userà `kris-configctl` per mostrare stato/diff e, solo su richiesta esplicita, eseguire fetch/sync/build/apply.

Non esistono timer, pull al boot, pull al login o apply automatici.

## Prima installazione

1. Clonare questo repo in `~/krisNOS-config`.
2. Generare il vero `hosts/krisnos/hardware-configuration.nix` sulla macchina target.
3. Aggiungerlo a Git solo dopo averlo controllato.
4. Eseguire `nix flake lock` e committare `flake.lock`.
5. Validare/buildare prima di qualsiasi `switch`.

Finché `hardware-configuration.nix` non esiste, la configurazione reale `krisnos` non viene esposta dal flake: è una protezione intenzionale contro un apply prematuro.

## Cosa NON deve entrare qui

- password o hash non destinati al versionamento;
- chiavi SSH/GPG;
- token GitHub;
- credenziali Wi-Fi/VPN;
- `/etc/NetworkManager/system-connections`;
- database Bluetooth;
- qualsiasi segreto applicativo.

Il repository è attualmente pubblico: questa regola va rispettata anche se in futuro diventerà privato.
