;; Royalty Distribution Contract
;; This contract allocates payments based on actual usage

(define-data-var admin principal tx-sender)

;; Map to track royalty payments
(define-map royalty-payments
  { composition-id: uint, payment-period: uint }
  { amount: uint, distributed: bool }
)

;; Map to track royalty distributions to composers
(define-map composer-royalties
  { composer: principal, payment-period: uint }
  { total-amount: uint, last-updated: uint }
)

;; Function to record a royalty payment for a composition
(define-public (record-royalty-payment
    (composition-id uint)
    (payment-period uint)
    (amount uint))
  (begin
    ;; In a real implementation, we would:
    ;; 1. Verify the caller is authorized
    ;; 2. Verify the composition exists

    ;; Record the payment
    (map-set royalty-payments
      { composition-id: composition-id, payment-period: payment-period }
      { amount: amount, distributed: false }
    )

    (ok true)
  )
)

;; Function to distribute royalties to a composer
(define-public (distribute-royalties
    (composition-id uint)
    (payment-period uint)
    (composer principal))
  (let
    (
      (payment-data (unwrap! (map-get? royalty-payments
                              { composition-id: composition-id, payment-period: payment-period })
                            (err u404)))
      (current-royalties (default-to
                          { total-amount: u0, last-updated: u0 }
                          (map-get? composer-royalties
                                    { composer: composer, payment-period: payment-period })))
    )
    ;; Verify payment hasn't been distributed yet
    (asserts! (not (get distributed payment-data)) (err u403))

    ;; In a real implementation, we would:
    ;; 1. Verify the composer is the owner of the composition
    ;; 2. Calculate the correct royalty amount (may involve splits with multiple parties)

    ;; Update composer royalties
    (map-set composer-royalties
      { composer: composer, payment-period: payment-period }
      {
        total-amount: (+ (get total-amount current-royalties) (get amount payment-data)),
        last-updated: block-height
      }
    )

    ;; Mark payment as distributed
    (map-set royalty-payments
      { composition-id: composition-id, payment-period: payment-period }
      (merge payment-data { distributed: true })
    )

    (ok true)
  )
)

;; Function to get royalty payment details
(define-read-only (get-royalty-payment (composition-id uint) (payment-period uint))
  (map-get? royalty-payments { composition-id: composition-id, payment-period: payment-period })
)

;; Function to get composer royalty details
(define-read-only (get-composer-royalties (composer principal) (payment-period uint))
  (map-get? composer-royalties { composer: composer, payment-period: payment-period })
)
