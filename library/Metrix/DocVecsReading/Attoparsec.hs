module Metrix.DocVecsReading.Attoparsec where

import Metrix.DocVecsReading.Prelude hiding (takeWhile)
import Metrix.NlpData
import Metrix.ClickstreamData
import Data.Attoparsec.ByteString.Char8
import qualified Data.Vector as D


row :: Parser (UriId, DocVec)
row =
  do
    uriId <- UriId <$> decimal
    docVec <- DocVec <$> D.replicateM 20000 (char '\t' *> double)
    void (char '\n') <|> endOfInput
    return (uriId, docVec)
