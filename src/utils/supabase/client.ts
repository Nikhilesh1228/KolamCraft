import { createClient, SupabaseClient } from "@supabase/supabase-js";
import { projectId, publicAnonKey } from "./info";

const supabaseUrl = projectId ? `https://${projectId}.supabase.co` : "";
const supabaseKey = publicAnonKey || "";

export const isSupabaseConfigured = Boolean(supabaseUrl && supabaseKey);

let client: SupabaseClient | null = null;

export const getSupabase = (): SupabaseClient => {
  if (!isSupabaseConfigured) {
    throw new Error(
      "Supabase is not configured. Add VITE_SUPABASE_PROJECT_ID and VITE_SUPABASE_ANON_KEY to .env to enable cloud persistence."
    );
  }

  if (!client) {
    client = createClient(supabaseUrl, supabaseKey);
  }
  return client;
};
