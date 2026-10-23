using System;
using System.Collections.Generic;
using System.Linq; 
using libsvm;

namespace SVMTextClassifier
{
    public class TextClassificationProblemBuilder
    { 
        public svm_problem CreateProblem(IEnumerable<string> x, double[] y, IReadOnlyList<string> vocabulary)
        {
            return new svm_problem
            {
                y = y, 
                x = x.Select(xVector => CreateNode(xVector, vocabulary)).ToArray(),
                l = y.Length
            }; 
        }

        public static svm_node[] CreateNode(string x, IReadOnlyList<string> vocabulary)
        {
            var node = new List<svm_node>(vocabulary.Count);

            string[] words = x.Split(new[] { ' ', '\t' }, StringSplitOptions.RemoveEmptyEntries); 

            for (int i = 0; i < vocabulary.Count; i++)
            {
                int occurenceCount = words.Count(s => String.Equals(s, vocabulary[i], StringComparison.OrdinalIgnoreCase));
                if(occurenceCount == 0)
                    continue;

                node.Add(new svm_node
                {
                    index = i+1,
                    value = occurenceCount
                });
            }

            return node.ToArray();
        }
    }
}