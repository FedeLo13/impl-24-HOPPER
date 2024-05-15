using Newtonsoft.Json;
public class JsonDateConverter : JsonConverter<DateTime>
{
    public override DateTime ReadJson(JsonReader reader, Type objectType, DateTime existingValue, bool hasExistingValue, JsonSerializer serializer)
    {
        if (reader.Value == null)
            return DateTime.MinValue;
        return Convert.ToDateTime(reader.Value);
    }

    public override void WriteJson(JsonWriter writer, DateTime value, JsonSerializer serializer)
    {
        writer.WriteValue(value.ToString("yyyy-MM-dd"));
    }
}
