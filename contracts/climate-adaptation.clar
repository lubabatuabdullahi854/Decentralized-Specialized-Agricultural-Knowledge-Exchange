;; Climate Adaptation Contract
;; Tracks strategies for changing climate conditions

(define-data-var last-strategy-id uint u0)

(define-map climate-strategies
  { strategy-id: uint }
  {
    farmer-id: uint,
    title: (string-utf8 100),
    description: (string-utf8 500),
    climate-challenge: (string-utf8 100),
    solution: (string-utf8 500),
    effectiveness: uint,
    timestamp: uint
  }
)

(define-map strategy-votes
  { strategy-id: uint, voter: principal }
  { effectiveness: uint }
)

;; Document a new climate adaptation strategy
(define-public (document-strategy
    (farmer-id uint)
    (title (string-utf8 100))
    (description (string-utf8 500))
    (climate-challenge (string-utf8 100))
    (solution (string-utf8 500))
    (effectiveness uint))
  (let
    (
      (new-id (+ (var-get last-strategy-id) u1))
    )
    (asserts! (<= effectiveness u5) (err u1)) ;; Effectiveness must be between 0-5

    (map-set climate-strategies
      { strategy-id: new-id }
      {
        farmer-id: farmer-id,
        title: title,
        description: description,
        climate-challenge: climate-challenge,
        solution: solution,
        effectiveness: effectiveness,
        timestamp: block-height
      }
    )
    (var-set last-strategy-id new-id)
    (ok new-id)
  )
)

;; Vote on a strategy's effectiveness
(define-public (vote-on-strategy (strategy-id uint) (effectiveness uint))
  (begin
    (asserts! (<= effectiveness u5) (err u2)) ;; Effectiveness must be between 0-5
    (asserts! (is-some (map-get? climate-strategies { strategy-id: strategy-id })) (err u3))

    (map-set strategy-votes
      { strategy-id: strategy-id, voter: tx-sender }
      { effectiveness: effectiveness }
    )
    (ok true)
  )
)

;; Get a strategy by ID
(define-read-only (get-strategy (strategy-id uint))
  (map-get? climate-strategies { strategy-id: strategy-id })
)

;; Check if a strategy matches a specific climate challenge
(define-read-only (strategy-matches-challenge (strategy-id uint) (challenge (string-utf8 100)))
  (let ((strategy-info (map-get? climate-strategies { strategy-id: strategy-id })))
    (if (is-some strategy-info)
      (is-eq (get climate-challenge (unwrap! strategy-info false)) challenge)
      false
    )
  )
)

;; Get the vote for a strategy by a specific voter
(define-read-only (get-strategy-vote (strategy-id uint) (voter principal))
  (map-get? strategy-votes { strategy-id: strategy-id, voter: voter })
)

;; Read-only function to get the last strategy ID
(define-read-only (get-last-strategy-id)
  (var-get last-strategy-id)
)

