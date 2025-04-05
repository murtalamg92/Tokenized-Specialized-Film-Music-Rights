;; Composition Registration Contract
;; This contract records details of musical works

(define-data-var admin principal tx-sender)

;; Define a non-fungible token for compositions
(define-non-fungible-token composition uint)

;; Counter for composition IDs
(define-data-var composition-id-counter uint u1)

;; Map to store composition details
(define-map compositions uint
  {
    title: (string-utf8 100),
    composer: principal,
    creation-date: uint,
    duration: uint,
    genre: (string-utf8 50),
    metadata-uri: (string-utf8 256)
  }
)

;; Function to register a new composition
(define-public (register-composition
    (title (string-utf8 100))
    (duration uint)
    (genre (string-utf8 50))
    (metadata-uri (string-utf8 256)))
  (let
    (
      (composer tx-sender)
      (composition-id (var-get composition-id-counter))
    )
    ;; Verify composer is registered (would call the composer verification contract in a real implementation)
    ;; For simplicity, we're not making the contract call here

    ;; Mint the NFT to the composer
    (try! (nft-mint? composition composition-id composer))

    ;; Store composition details
    (map-set compositions composition-id
      {
        title: title,
        composer: composer,
        creation-date: block-height,
        duration: duration,
        genre: genre,
        metadata-uri: metadata-uri
      }
    )

    ;; Increment the counter
    (var-set composition-id-counter (+ composition-id u1))

    ;; Return the composition ID
    (ok composition-id)
  )
)

;; Function to get composition details
(define-read-only (get-composition-details (composition-id uint))
  (map-get? compositions composition-id)
)

;; Function to check composition ownership
(define-read-only (is-composition-owner (composition-id uint) (owner principal))
  (is-eq (nft-get-owner? composition composition-id) (some owner))
)
