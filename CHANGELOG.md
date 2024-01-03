# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.4.1] - 2024-01-03
### Changed
- Change the storage account naming convention
- Clean up and fmt

## [0.4.0] - 2024-01-03
### Added
- Add a Key Vault to store and fetch the IPsec preshared key
- Update the architecture diagram to reflect the above

## [0.3.0] - 2024-01-02
### Changed
- Change the vnet_peering module from a generic one to a "transit vnet to databricks vnet" one.
This is more in-line with the exercise's objective.
- Move the Private Endpoint resource from the storage module to the transit_connetivity one.
This is more in-line with the exercise's objective.
- Update the architecture diagram to reflect the above
- Update README.md

## [0.2.2] - 2023-12-30
### Fixed
- Add depency to module.transit_connectivity on module.vnet_peering as there's a potential race condition caused by a delay when provisioning the virtual network gateway
- Update README.md

## [0.2.1] - 2023-12-30
### Changed
- Update the architecture diagram
- Update README.md

## [0.2.0] - 2023-12-29
### Added
- Add the initial version of the draw.io architecture diagram
- Update README.md

## [0.1.1] - 2023-12-29
### Fixed
- Add missing user defined routes required when using vnet injection
- Update README.md

## [0.1.0] - 2023-12-23
### Added
- Initial version
- Terraform modules:
  - databricks
  - networks
  - storage
  - transit_connectivity
  - vnet_peering
