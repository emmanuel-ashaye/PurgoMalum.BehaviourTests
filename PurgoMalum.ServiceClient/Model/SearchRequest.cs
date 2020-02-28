using System;
namespace PurgoMalum.ServiceClient.Model
{
    public class SearchRequest
    {
        public string ResponseType { get; set; }

        public string Text { get; set; }

        public string ReplacementWord { get; set; }

        public string ReplacementCharacter { get; set; }
    }
}
