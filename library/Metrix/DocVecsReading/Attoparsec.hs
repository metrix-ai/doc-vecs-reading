module Metrix.DocVecsReading.Attoparsec where

import Metrix.DocVecsReading.Prelude hiding (takeWhile)
import Metrix.NlpData
import Metrix.ClickstreamData
import Data.Attoparsec.ByteString.Char8
import qualified Data.Vector.Unboxed as D


row :: Parser (Int, D.Vector Float)
row =
  do
    !uriId <- decimal
    !docVec <- D.replicateM 20000 (char '\t' *> rational)
    void (char '\n') <|> endOfInput
    return (uriId, docVec)
