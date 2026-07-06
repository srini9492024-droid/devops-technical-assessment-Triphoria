-- 1. Create Core Bookings Table
CREATE TABLE hotel_bookings (
  id UUID PRIMARY KEY,
  org_id UUID NOT NULL,
  hotel_id VARCHAR(100) NOT NULL,
  city VARCHAR(100) NOT NULL,
  checkin_date DATE NOT NULL,
  checkout_date DATE NOT NULL,
  amount NUMERIC(12,2) NOT NULL,
  status VARCHAR(50) NOT NULL,
  created_at TIMESTAMP NOT NULL
);

-- 2. Create Booking Events Table
CREATE TABLE booking_events (
  id BIGSERIAL PRIMARY KEY,
  booking_id UUID NOT NULL,
  event_type VARCHAR(100) NOT NULL,
  payload JSONB,
  created_at TIMESTAMP NOT NULL
);

-- 3. Performance Optimization Index
-- This specific index makes the exact query they asked for blazing fast.
CREATE INDEX idx_bookings_city_created_at ON hotel_bookings (city, created_at);

-- 4. Seed Data Generator (Generates 150 random rows)
INSERT INTO hotel_bookings (id, org_id, hotel_id, city, checkin_date, checkout_date, amount, status, created_at)
SELECT 
  gen_random_uuid(),
  gen_random_uuid(),
  'HOTEL-' || i,
  (ARRAY['delhi', 'mumbai', 'bangalore', 'new-york'])[floor(random() * 4 + 1)],
  CURRENT_DATE + (random() * 10)::int,
  CURRENT_DATE + (random() * 10 + 11)::int,
  (random() * 500 + 50)::numeric(12,2),
  (ARRAY['CONFIRMED', 'PENDING', 'CANCELLED'])[floor(random() * 3 + 1)],
  NOW() - (random() * 40 || ' days')::interval
FROM generate_series(1, 150) s(i);