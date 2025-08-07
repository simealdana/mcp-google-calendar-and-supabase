export interface Event {
  event_id: string;
  event_name: string;
  event_description?: string;
  event_start_date: string;
  event_end_date: string;
  attendaces?: string[];
  created_at: string;
  updated_at: string;
  time_zone?: string;
  status: "booked" | "cancelled" | "completed";
  location?: string;
}
