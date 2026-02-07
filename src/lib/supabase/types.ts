export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[];

export interface Database {
  public: {
    Tables: {
      standards: {
        Row: {
          id: string;
          name: string;
          category: string;
          description: string;
          measurements: Json | null;
          aliases: string[] | null;
          era_start: string | null;
          era_end: string | null;
          region: string | null;
          source_url: string | null;
          source_notes: string | null;
          created_at: string;
          updated_at: string;
        };
        Insert: {
          id?: string;
          name: string;
          category: string;
          description: string;
          measurements?: Json | null;
          aliases?: string[] | null;
          era_start?: string | null;
          era_end?: string | null;
          region?: string | null;
          source_url?: string | null;
          source_notes?: string | null;
          created_at?: string;
          updated_at?: string;
        };
        Update: {
          id?: string;
          name?: string;
          category?: string;
          description?: string;
          measurements?: Json | null;
          aliases?: string[] | null;
          era_start?: string | null;
          era_end?: string | null;
          region?: string | null;
          source_url?: string | null;
          source_notes?: string | null;
          created_at?: string;
          updated_at?: string;
        };
      };
      compatibility_rules: {
        Row: {
          id: string;
          standard_a_id: string;
          standard_b_id: string;
          compatibility_type: string;
          adapter_needed: string | null;
          confidence: string;
          caveats: string | null;
          source_url: string | null;
          source_notes: string | null;
          created_at: string;
          updated_at: string;
        };
        Insert: {
          id?: string;
          standard_a_id: string;
          standard_b_id: string;
          compatibility_type: string;
          adapter_needed?: string | null;
          confidence?: string;
          caveats?: string | null;
          source_url?: string | null;
          source_notes?: string | null;
          created_at?: string;
          updated_at?: string;
        };
        Update: {
          id?: string;
          standard_a_id?: string;
          standard_b_id?: string;
          compatibility_type?: string;
          adapter_needed?: string | null;
          confidence?: string;
          caveats?: string | null;
          source_url?: string | null;
          source_notes?: string | null;
          created_at?: string;
          updated_at?: string;
        };
      };
      components: {
        Row: {
          id: string;
          name: string;
          manufacturer: string;
          model: string | null;
          year_start: string | null;
          year_end: string | null;
          category: string;
          standard_interfaces: Json | null;
          specifications: Json | null;
          notes: string | null;
          source_url: string | null;
          image_url: string | null;
          created_at: string;
          updated_at: string;
        };
        Insert: {
          id?: string;
          name: string;
          manufacturer: string;
          model?: string | null;
          year_start?: string | null;
          year_end?: string | null;
          category: string;
          standard_interfaces?: Json | null;
          specifications?: Json | null;
          notes?: string | null;
          source_url?: string | null;
          image_url?: string | null;
          created_at?: string;
          updated_at?: string;
        };
        Update: {
          id?: string;
          name?: string;
          manufacturer?: string;
          model?: string | null;
          year_start?: string | null;
          year_end?: string | null;
          category?: string;
          standard_interfaces?: Json | null;
          specifications?: Json | null;
          notes?: string | null;
          source_url?: string | null;
          image_url?: string | null;
          created_at?: string;
          updated_at?: string;
        };
      };
      groupsets: {
        Row: {
          id: string;
          name: string;
          manufacturer: string;
          year_start: string | null;
          year_end: string | null;
          tier: string | null;
          region: string | null;
          component_ids: string[] | null;
          notes: string | null;
          source_url: string | null;
          created_at: string;
          updated_at: string;
        };
        Insert: {
          id?: string;
          name: string;
          manufacturer: string;
          year_start?: string | null;
          year_end?: string | null;
          tier?: string | null;
          region?: string | null;
          component_ids?: string[] | null;
          notes?: string | null;
          source_url?: string | null;
          created_at?: string;
          updated_at?: string;
        };
        Update: {
          id?: string;
          name?: string;
          manufacturer?: string;
          year_start?: string | null;
          year_end?: string | null;
          tier?: string | null;
          region?: string | null;
          component_ids?: string[] | null;
          notes?: string | null;
          source_url?: string | null;
          created_at?: string;
          updated_at?: string;
        };
      };
      measurement_conversions: {
        Row: {
          id: string;
          category: string;
          value_a: string;
          value_b: string;
          system_a: string;
          system_b: string;
          notes: string | null;
          source_url: string | null;
        };
        Insert: {
          id?: string;
          category: string;
          value_a: string;
          value_b: string;
          system_a: string;
          system_b: string;
          notes?: string | null;
          source_url?: string | null;
        };
        Update: {
          id?: string;
          category?: string;
          value_a?: string;
          value_b?: string;
          system_a?: string;
          system_b?: string;
          notes?: string | null;
          source_url?: string | null;
        };
      };
    };
    Views: Record<string, never>;
    Functions: Record<string, never>;
    Enums: Record<string, never>;
  };
}

export type Standard = Database["public"]["Tables"]["standards"]["Row"];
export type CompatibilityRule = Database["public"]["Tables"]["compatibility_rules"]["Row"];
export type Component = Database["public"]["Tables"]["components"]["Row"];
export type Groupset = Database["public"]["Tables"]["groupsets"]["Row"];
export type MeasurementConversion = Database["public"]["Tables"]["measurement_conversions"]["Row"];
