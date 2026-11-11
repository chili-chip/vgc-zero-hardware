# Work on the hardware

This page is for people who change the boards or these docs.

## Tools

| Tool | Version | Used for |
|---|---|---|
| [KiCad](https://www.kicad.org/) | 10 | Schematic and PCB |
| `kicad-cli` | 10 (comes with KiCad, or the `kicad/kicad:10.0` Docker image) | Renders, exports, CI |
| Python and MkDocs Material | See `docs/requirements.txt` | This site |

## Open the project

1. Clone the repository: `git clone https://github.com/chili-chip/vgc-zero-hardware`.
2. Open `vgc-zero.kicad_pro` in KiCad 10.
3. The project libraries load from `sym-lib-table` and `fp-lib-table`: `vgc-zero-symbols.kicad_sym`, `vgc-zero-footprints.pretty/` and `RPI_RMC20452T.kicad_sym`. 3D models are in `3d-models/`.

## Repository layout

| Path | Contents |
|---|---|
| `vgc-zero.kicad_*` | KiCad 10 schematic, PCB and project |
| `vgc-zero-symbols.kicad_sym`, `vgc-zero-footprints.pretty/` | Project symbols and footprints: module outlines and castellation lands |
| `RPI_RMC20452T.kicad_sym` | Official RM2 symbol from Raspberry Pi |
| `3d-models/` | STEP models of the modules and bought parts |
| `vgc-zero.glb` | 3D export of the assembled board |
| `scripts/export-jlcpcb.sh` | Builds the gerber zip and the hand-assembly BOM |
| `scripts/render-images.sh` | Regenerates the renders, drawings and schematic in `docs/` and `vgc-zero.glb` |
| `docs/` | This site (MkDocs) |
| `mkdocs.yml` | Site configuration |
| `.github/workflows/main.yml` | KiCad CI and release |
| `.github/workflows/docs.yml` | Builds this site and deploys it |

## Checks

CI runs on every push and pull request:

| Job | What it does |
|---|---|
| `kicad-ci` | ERC, DRC, schematic PDF, Gerbers and a PCB image |
| `jlcpcb` | Runs `scripts/export-jlcpcb.sh` |
| `docs` | `mkdocs build --strict`; on `master`, deploys to [hardware.chilichip.eu](https://hardware.chilichip.eu) |

!!! warning "Every DRC warning fails CI"
    The KiCad action runs DRC with `--exit-code-violations`. If a warning is accepted on purpose, add it to `drc_exclusions` in `vgc-zero.kicad_pro` instead of ignoring it.

## Release a new board version

1. Change the version on the silkscreen (`vgc zero vX.Y.Z`) and in the README.
2. Run `scripts/render-images.sh` and commit the new images.
3. Update these docs: specifications, pin map, parts list and the [revisions](revisions.md) page.
4. Merge to `master`, then push a tag: `git tag vX.Y.Z && git push origin vX.Y.Z`.
5. CI publishes a GitHub release with the schematic PDF, PCB image, Gerbers, JLCPCB zip and BOM.

!!! note "Docs show released boards only"
    The site describes the latest released board. Work that is not released goes on the [revisions](revisions.md#work-in-progress) page, marked as work in progress.

## Images on this site

| Image | Made by | Source |
|---|---|---|
| `docs/images/top.png`, `bottom.png`, `iso.png`, `iso-bottom.png` | `scripts/render-images.sh` | This repository |
| `docs/images/placement-front.svg`, `placement-back.svg` | `scripts/render-images.sh` | This repository |
| `docs/schematics/main-board.svg` | `scripts/render-images.sh` | This repository |
| `docs/images/modules/*.png` | Each module's own `scripts/render-images.sh` | Copied from the module repositories at the versions on the [modules](modules/index.md) page |
| `docs/schematics/*-module.svg` | `kicad-cli sch export svg` | Module repositories, same versions |
| `docs/images/revisions/*.png` | `kicad-cli pcb render` on the old tags | This repository, tags v1.1.4 and v2.0.0 |

Without KiCad installed, run the script in Docker:

```sh
docker run --rm -u "$(id -u)" -e HOME=/tmp -v "$PWD":/w -w /w kicad/kicad:10.0 scripts/render-images.sh
```

To refresh a module's images, check out the module repository at its release tag, then:

```sh
cp ../chili-audio-module-hardware/docs/images/iso.png docs/images/modules/audio-iso.png
kicad-cli sch export svg -o /tmp/sch ../chili-audio-module-hardware/chili-audio-module-hardware.kicad_sch
cp /tmp/sch/chili-audio-module-hardware.svg docs/schematics/audio-module.svg
```

## Edit this site

```sh
python -m venv .venv && . .venv/bin/activate
pip install -r docs/requirements.txt
mkdocs serve            # live preview on http://127.0.0.1:8000
mkdocs build --strict   # what CI runs: fails on broken links
```

Writing rules for these pages:

- Short, plain sentences. Tables for anything with more than two facts.
- Call the device "chilichip console" or "the console". Keep "VGC Zero" only in file names, tags and repository names.
- Link every part to its datasheet and every claim to its issue.
- Mark anything not released as work in progress.

## Deployment

The site is a static MkDocs build deployed to Cloudflare Pages with [`cloudflare/wrangler-action`](https://github.com/cloudflare/wrangler-action) ([direct upload](https://developers.cloudflare.com/pages/how-to/use-direct-upload-with-continuous-integration/)). The workflow needs the `CLOUDFLARE_API_TOKEN` and `CLOUDFLARE_ACCOUNT_ID` secrets. The Pages project `chilichip-hardware` and its custom domain `hardware.chilichip.eu` are set up once in the Cloudflare dashboard, not in CI.
