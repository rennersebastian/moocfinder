json.extract! review, :id, :rating, :review, :created_at, :updated_at, :course_id
json.url review_url(review, format: :json)