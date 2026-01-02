{
  buildGoModule,
  fetchFromGitHub,
  lib,
  nixosTests,
}:
buildGoModule rec {
  pname = "litestream";
  version = "0.5.5";

  src = fetchFromGitHub {
    owner = "benbjohnson";
    repo = "litestream";
    rev = "v${version}";
    hash = "sha256-tsLd6RMqiwCtY8Lx5LtMfMAnIJLRBgJKok5N0MUTV8o=";
  };

  ldflags = [
    "-s"
    "-w"
    "-X main.Version=${version}"
  ];

  vendorHash = "sha256-MFKyECRWvhHwV0NZuuUQ0OYHpyTjRg0vKHuDNzaZJ7c=";

  passthru.tests = { inherit (nixosTests) litestream; };

  meta = {
    description = "Streaming replication for SQLite";
    mainProgram = "litestream";
    license = lib.licenses.asl20;
    homepage = "https://litestream.io/";
    maintainers = with lib.maintainers; [ fbrs ];
  };
}
