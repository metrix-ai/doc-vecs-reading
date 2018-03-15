module Metrix.DocVecsReading.Attoparsec where

import Metrix.DocVecsReading.Prelude hiding (takeWhile)
import Metrix.NlpData
import Metrix.ClickstreamData
import Data.Attoparsec.ByteString.Char8
import qualified Data.Vector.Unboxed as D
import qualified Data.Vector as A


rowPrims :: Parser (Int, D.Vector Float)
rowPrims =
  do
    !uriId <- decimal
    !docVec <- D.replicateM 20000 (char '\t' *> rational)
    void (char '\n') <|> endOfInput
    return (uriId, docVec)

rowUriIdAndDocVec :: Parser (UriId, DocVec)
rowUriIdAndDocVec =
  do
    !uriId <- UriId <$> decimal
    !docVec <- DocVec <$> A.replicateM 20000 (char '\t' *> double)
    void (char '\n') <|> endOfInput
    return (uriId, docVec)
