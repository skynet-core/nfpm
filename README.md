# nfpm

![build](https://img.shields.io/github/workflow/status/skynet-core/nfpm/main?style=for-the-badge)
![last commit](https://img.shields.io/github/last-commit/skynet-core/nfpm?style=for-the-badge)
![last release](https://img.shields.io/github/release-date/skynet-core/nfpm?color=red&logoColor=green&style=for-the-badge)

[nfpm](https://github.com/goreleaser/nfpm) tool packaged for using as GitHub Action.

## Inputs

### `config`

**Optional** Nfpm config path. Default is `nfpm.yaml`

### `packager`

**Required** Packager to use. `rpm` or `deb`

### `target`

**Optional** Output package name. Default is generic name based on config

## Example usage

    - name: Create deb package
      uses: skynet-core/nfpm@v1.3
      id: deb-package
      with:
        config: "custom.yaml"
        packager: "deb"
    - name: Create rpm package
      uses: skynet-core/nfpm@v1.3
      id: rpm-package
      with:
        config: "custom.yaml"
        packager: "rpm"