module Metrix.DocVecsReading.Potoki.Produce where

import Metrix.DocVecsReading.Prelude
import Metrix.NlpData
import Metrix.ClickstreamData
import Potoki.Produce
import qualified Metrix.DocVecsReading.Potoki.Transform as A


readFromFile :: FilePath -> Produce (Either IOException (Either Text (UriId, DocVec)))
readFromFile path =
  transform
    (right' A.parseTsv)
    (fileBytes path)
