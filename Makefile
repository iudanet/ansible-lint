lint::
	docker run --rm -i ghcr.io/hadolint/hadolint < Dockerfile

build-dev::
	docker buildx build . --tag iudanet/ansible:dev --tag registry.ott.local/publics/ansible-lint:4.2
