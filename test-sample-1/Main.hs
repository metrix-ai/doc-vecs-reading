import Prelude
import Metrix.DocVecsReading.IO
import Metrix.NlpData
import Metrix.ClickstreamData
import qualified Data.Vector as A


main =
  do
    readingResult <- readFromFile "samples/1.tsv"
    parsingResult <- case readingResult of
      Right x -> return x
      Left x -> throwIO x
    lookup <- case parsingResult of
      Right x -> return x
      Left x -> fail (show x)
    case lookup (UriId 9401) of
      Nothing -> fail "No expected URI is present"
      Just (DocVec docVec) -> when (A.length docVec /= 20000) (fail "Not 20000 topics")
