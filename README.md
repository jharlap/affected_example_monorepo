# Example Monorepo

## Env

For the go tools to work, set your GOPATH to `vendor:private` in this dir. To make this easier, use direnv (http://direnv.net) with a .envrc file

## Building

Run `make test` or `make image` in any service dir within `private/src/services`

## Vendoring

- `bin/vendor_dotgit.sh` prepares the vendor dir for committing after adding/modifying its contents.
- `bin/vendor_undotgit.sh` prepares the vendor dir for modification.
