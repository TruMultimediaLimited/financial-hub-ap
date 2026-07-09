-- Financial Hub — lock every table down to signed-in users only.
--
-- Run this once in the Supabase SQL Editor (Dashboard → SQL Editor → New
-- query → paste → Run). It does not touch or delete any existing rows —
-- it only adds access-control rules on top of the tables.
--
-- Before running this, create the one shared login Radone & Efty will both
-- use: Dashboard → Authentication → Users → Add user → set an email +
-- password and check "Auto Confirm User". The app's login screen then signs
-- in with that same email/password.
--
-- After this runs, the anon/public API key alone (the one embedded in
-- index.html) can no longer read or write these tables — a valid signed-in
-- session is required for every request, closing the "anyone with the link
-- has full read/write access" gap.

alter table hub_income          enable row level security;
alter table hub_expenses        enable row level security;
alter table credit_card_status  enable row level security;
alter table hub_debts           enable row level security;
alter table hub_emis            enable row level security;

create policy "authenticated only" on hub_income
  for all using (auth.role() = 'authenticated') with check (auth.role() = 'authenticated');

create policy "authenticated only" on hub_expenses
  for all using (auth.role() = 'authenticated') with check (auth.role() = 'authenticated');

create policy "authenticated only" on credit_card_status
  for all using (auth.role() = 'authenticated') with check (auth.role() = 'authenticated');

create policy "authenticated only" on hub_debts
  for all using (auth.role() = 'authenticated') with check (auth.role() = 'authenticated');

create policy "authenticated only" on hub_emis
  for all using (auth.role() = 'authenticated') with check (auth.role() = 'authenticated');
