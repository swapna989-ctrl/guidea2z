-- ==========================================================
-- GuideA2Z Supabase Database Schema
-- Run this script in your Supabase SQL Editor (https://supabase.com/dashboard)
-- ==========================================================

-- 1. PROFILES TABLE
CREATE TABLE IF NOT EXISTS public.profiles (
  id UUID REFERENCES auth.users(id) ON DELETE CASCADE PRIMARY KEY,
  email TEXT NOT NULL,
  full_name TEXT,
  avatar_url TEXT,
  role TEXT DEFAULT 'member',
  bio TEXT,
  -- Academic details (set during onboarding in updated_signup_details)
  department TEXT,
  year TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- If the table already exists and needs the new columns, run these:
ALTER TABLE public.profiles ADD COLUMN IF NOT EXISTS department TEXT;
ALTER TABLE public.profiles ADD COLUMN IF NOT EXISTS year TEXT;

ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Public profiles are viewable by everyone." ON public.profiles
  FOR SELECT USING (true);

CREATE POLICY "Users can insert their own profile." ON public.profiles
  FOR INSERT WITH CHECK (auth.uid() = id);

CREATE POLICY "Users can update own profile." ON public.profiles
  FOR UPDATE USING (auth.uid() = id);

-- 2. GUIDES TABLE
CREATE TABLE IF NOT EXISTS public.guides (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  title TEXT NOT NULL,
  category TEXT DEFAULT 'General',
  location TEXT DEFAULT 'Local',
  summary TEXT,
  steps JSONB DEFAULT '[]'::jsonb,
  author_id UUID REFERENCES auth.users(id) ON DELETE SET NULL,
  author_name TEXT DEFAULT 'Community Member',
  views_count INT DEFAULT 0,
  likes_count INT DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE public.guides ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Guides are viewable by everyone." ON public.guides
  FOR SELECT USING (true);

-- FIXED: Removed the dangerous "OR true" that allowed anonymous inserts
DROP POLICY IF EXISTS "Authenticated users can create guides." ON public.guides;
CREATE POLICY "Authenticated users can create guides." ON public.guides
  FOR INSERT WITH CHECK (auth.uid() IS NOT NULL);

CREATE POLICY "Authors can update their own guides." ON public.guides
  FOR UPDATE USING (auth.uid() = author_id);

CREATE POLICY "Authors can delete their own guides." ON public.guides
  FOR DELETE USING (auth.uid() = author_id);

-- 3. SAVED GUIDES TABLE
CREATE TABLE IF NOT EXISTS public.saved_guides (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  guide_id UUID REFERENCES public.guides(id) ON DELETE CASCADE NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(user_id, guide_id)
);

ALTER TABLE public.saved_guides ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view their saved guides." ON public.saved_guides
  FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can save guides." ON public.saved_guides
  FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can unsave guides." ON public.saved_guides
  FOR DELETE USING (auth.uid() = user_id);

-- AUTOMATIC PROFILE TRIGGER ON USER SIGNUP
-- Creates a profile row automatically when a new user registers
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.profiles (id, email, full_name)
  VALUES (
    new.id,
    new.email,
    new.raw_user_meta_data->>'full_name'
  )
  ON CONFLICT (id) DO NOTHING;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();
