import Prelude
import Metrix.DocVecsReading.IO
import Metrix.NlpData
import qualified Data.Vector as A

main =
  do
    readingResult <- readFromFile "samples/1.tsv"
    parsingResult <- case readingResult of
      Right x -> return x
      Left x -> throwIO x
    rows <- case parsingResult of
      Right x -> return x
      Left x -> fail (show x)
    unless (A.length rows == 10) (fail "Not 10 rows")
    unless (A.all ((== 20000) . A.length . (\ (DocVec x) -> x) . snd) rows) (fail "Not 20000 topics")

