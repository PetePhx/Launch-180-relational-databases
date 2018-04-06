CREATE TABLE expenses (
  id SERIAL PRIMARY KEY,
  amount NUMERIC(6,2) NOT NULL,
  memo TEXT NOT NULL,
  created_on DATE NOT NULL
);

ALTER TABLE expenses
  ADD CONSTRAINT positive_amounts
  CHECK (amount >= 0.01);
