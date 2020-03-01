using System;
using FluentAssertions;
using PurgoMalum.BehaviourTests.Context;
using PurgoMalum.ServiceClient;
using TechTalk.SpecFlow;

namespace PurgoMalum.BehaviourTests.Features
{
    [Binding]
    public class WordFilterSteps
    {

        private readonly SearchContext _searchContext;

        private readonly ISearchService _searchService;

        public WordFilterSteps(ISearchService searchService, SearchContext searchContext)
        {
            _searchService = searchService;
            _searchContext = searchContext;
        }

        [StepDefinition("I call the word filter service")]
        public void ICallTheWordFilterService()
        {
        }


        [StepDefinition(@"I specify the response type as '(.*)'")]
        public void ISpecifyTheResponseTypeAs(string responseType)
        {
            _searchContext.ResponseType = responseType;
        }

        [StepDefinition(@"I enter '(.*)'")]
        public void IEnter(string intputText)
        {
            _searchContext.Text = intputText;
        }

        [StepDefinition(@"I specify profain word replacement text as '(.*)'")]
        public void ISpecifyProfainWordReplacementAs(string replacementWord)
        {
            _searchContext.ReplacementWord = replacementWord;
        }

        [StepDefinition(@"I specify profain word replacement character as '(.*)'")]
        public void ISpecifyProfainWordReplacementCharacterAs(string replacementCharacter)
        {
            _searchContext.ReplacementCharacter = replacementCharacter;
        }

        [StepDefinition(@"I add these words to the replacement list '(.*)'")]
        public void IAddTheseWordsToTheReplacementList(string replacementList)
        {
            _searchContext.ReplacementList = replacementList;
        }

        [StepDefinition("the output (?:text|error) is '(.*)'")]
        public void TheOutputTextIs(string expectedOutputText)
        {
            var actualOutputText = _searchService.GetSearchResult(_searchContext.ResponseType, _searchContext.Text,
                _searchContext.ReplacementWord, _searchContext.ReplacementCharacter, _searchContext.ReplacementList);
            actualOutputText.Should().BeEquivalentTo(expectedOutputText);
        }
    }
}
