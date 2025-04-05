;; Technique Documentation Contract
;; Records successful farming practices

(define-data-var last-technique-id uint u0)

(define-map techniques
  { technique-id: uint }
  {
    farmer-id: uint,
    title: (string-utf8 100),
    description: (string-utf8 500),
    crop: (string-utf8 50),
    climate-condition: (string-utf8 100),
    success-rating: uint,
    timestamp: uint
  }
)

(define-map technique-votes
  { technique-id: uint, voter: principal }
  { rating: uint }
)

;; Document a new farming technique
(define-public (document-technique
    (farmer-id uint)
    (title (string-utf8 100))
    (description (string-utf8 500))
    (crop (string-utf8 50))
    (climate-condition (string-utf8 100))
    (success-rating uint))
  (let
    (
      (new-id (+ (var-get last-technique-id) u1))
    )
    (asserts! (<= success-rating u5) (err u1)) ;; Rating must be between 0-5

    (map-set techniques
      { technique-id: new-id }
      {
        farmer-id: farmer-id,
        title: title,
        description: description,
        crop: crop,
        climate-condition: climate-condition,
        success-rating: success-rating,
        timestamp: block-height
      }
    )
    (var-set last-technique-id new-id)
    (ok new-id)
  )
)

;; Vote on a technique's effectiveness
(define-public (vote-on-technique (technique-id uint) (rating uint))
  (begin
    (asserts! (<= rating u5) (err u2)) ;; Rating must be between 0-5
    (asserts! (is-some (map-get? techniques { technique-id: technique-id })) (err u3))

    (map-set technique-votes
      { technique-id: technique-id, voter: tx-sender }
      { rating: rating }
    )
    (ok true)
  )
)

;; Get a technique by ID
(define-read-only (get-technique (technique-id uint))
  (map-get? techniques { technique-id: technique-id })
)

;; Check if a technique matches a specific crop
(define-read-only (technique-matches-crop (technique-id uint) (crop-name (string-utf8 50)))
  (let ((technique-info (map-get? techniques { technique-id: technique-id })))
    (if (is-some technique-info)
      (is-eq (get crop (unwrap! technique-info false)) crop-name)
      false
    )
  )
)

;; Get the vote for a technique by a specific voter
(define-read-only (get-technique-vote (technique-id uint) (voter principal))
  (map-get? technique-votes { technique-id: technique-id, voter: voter })
)

;; Read-only function to get the last technique ID
(define-read-only (get-last-technique-id)
  (var-get last-technique-id)
)

