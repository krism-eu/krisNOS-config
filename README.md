# krisNOS-config

Configurazione personale di krisNOS.

Questo repository descrive **la macchina e le preferenze personali**; il framework, i moduli di sistema, l'installer Icicle e il codice di krisNCC vivono in [`krism-eu/krisNOS`](https://github.com/krism-eu/krisNOS).

## Collegamento

`flake.nix` importa `krisNOS` come input GitHub e usa il modulo `krisNOS.nixosModules.krisos`. La dipendenza è volutamente unidirezionale:

```text
krisNOS-config  --->  krisNOS
config personale      framework/moduli/krisNCC
```

`krisNOS` non dipende da questo repository.

## Sync

La sincronizzazione è **sempre manuale**. krisNCC usa `kris-configctl` per mostrare stato/diff e, solo su richiesta esplicita, eseguire fetch/sync/build/apply.

Non esistono timer, pull al boot, pull al login o apply automatici.

## Installazione e primo bootstrap

L'installazione iniziale del sistema viene eseguita dalla ISO krisNOS tramite Icicle. Icicle genera la configurazione hardware della macchina reale e installa il framework krisNOS; questo repository personale entra in gioco dopo il primo avvio.

Per collegare la macchina alla configurazione personale:

1. clonare questo repo in `~/krisNOS-config` (oppure usare `kris-configctl init`);
2. aggiungere in `hosts/krisnos/hardware-configuration.nix` la configurazione hardware generata per la macchina reale, dopo averla controllata;
3. aggiornare esplicitamente il lock del framework con `nix flake update krisNOS` quando si vuole adottare una nuova revisione di krisNOS, quindi controllare e committare `flake.lock`;
4. eseguire `kris-configctl validate` e `kris-configctl build`;
5. solo dopo, applicare con `kris-configctl apply` o con il pulsante **Applica** di krisNCC.

`kris-configctl` non modifica mai `flake.lock` durante validate/build/apply: un lock vecchio resta vecchio finché non viene aggiornato intenzionalmente.

Se l'hostname scelto durante Icicle non coincide con il nome del solo host presente in questo repo, `kris-configctl` seleziona automaticamente quell'unico host. `KRISOS_HOST` resta disponibile come override esplicito quando il repository contiene più host.

La policy iniziale è coerente con krisNCC: l'utente amministratore è nel gruppo `wheel` e le piccole operazioni privilegiate non interattive possono usare il wrapper sudo di NixOS. Le credenziali restano locali e non vengono versionate.

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
