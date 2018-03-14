module Metrix.DocVecsReading.IO where

import Metrix.DocVecsReading.Prelude
import Metrix.NlpData
import Metrix.ClickstreamData
import qualified Potoki.Transform as A
import qualified Potoki.IO as C
import qualified Potoki.Produce as D
import qualified Potoki.Consume as E
import qualified Metrix.DocVecsReading.Attoparsec as B


readFromFile :: FilePath -> IO (Either IOException (Either Text (Vector (UriId, DocVec))))
readFromFile path =
  C.produceAndConsume
    (D.fileBytes path)
    (right' (E.transform
      (A.parseBytes B.row)
      (right' E.vector)))
