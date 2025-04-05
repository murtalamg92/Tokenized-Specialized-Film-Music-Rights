;; Usage Licensing Contract
;; This contract manages permissions for film and media usage

(define-data-var admin principal tx-sender)

;; License types
(define-constant LICENSE-TYPE-FILM u1)
(define-constant LICENSE-TYPE-TV u2)
(define-constant LICENSE-TYPE-STREAMING u3)
(define-constant LICENSE-TYPE-COMMERCIAL u4)

;; License status
(define-constant LICENSE-STATUS-ACTIVE u1)
(define-constant LICENSE-STATUS-EXPIRED u2)
(define-constant LICENSE-STATUS-REVOKED u3)

;; Counter for license IDs
(define-data-var license-id-counter uint u1)

;; Map to store license details
(define-map licenses uint
  {
    composition-id: uint,
    licensee: principal,
    license-type: uint,
    start-date: uint,
    end-date: uint,
    status: uint,
    fee-paid: uint
  }
)

;; Function to issue a new license
(define-public (issue-license
    (composition-id uint)
    (license-type uint)
    (start-date uint)
    (end-date uint)
    (fee uint))
  (let
    (
      (licensee tx-sender)
      (license-id (var-get license-id-counter))
    )
    ;; In a real implementation, we would:
    ;; 1. Verify the composition exists
    ;; 2. Check if the caller has permission to license it
    ;; 3. Process payment

    ;; Store license details
    (map-set licenses license-id
      {
        composition-id: composition-id,
        licensee: licensee,
        license-type: license-type,
        start-date: start-date,
        end-date: end-date,
        status: LICENSE-STATUS-ACTIVE,
        fee-paid: fee
      }
    )

    ;; Increment the counter
    (var-set license-id-counter (+ license-id u1))

    ;; Return the license ID
    (ok license-id)
  )
)

;; Function to revoke a license (by admin or composition owner)
(define-public (revoke-license (license-id uint))
  (let
    (
      (license-data (unwrap! (map-get? licenses license-id) (err u404)))
    )
    ;; In a real implementation, we would verify the caller is either:
    ;; 1. The admin
    ;; 2. The composition owner

    ;; Update license status
    (map-set licenses license-id
      (merge license-data { status: LICENSE-STATUS-REVOKED })
    )

    (ok true)
  )
)

;; Function to check if a license is valid
(define-read-only (is-license-valid (license-id uint))
  (let
    (
      (license-data (unwrap-panic (map-get? licenses license-id)))
    )
    (and
      (is-eq (get status license-data) LICENSE-STATUS-ACTIVE)
      (>= (get end-date license-data) block-height)
    )
  )
)

;; Function to get license details
(define-read-only (get-license-details (license-id uint))
  (map-get? licenses license-id)
)
