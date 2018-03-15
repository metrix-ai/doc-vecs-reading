module Metrix.DocVecsReading.Potoki.Transform where

import Metrix.DocVecsReading.Prelude
import Metrix.NlpData
import Metrix.ClickstreamData
import Potoki.Transform
import qualified Metrix.DocVecsReading.Attoparsec as B


parseTsv :: Transform ByteString (Either Text (UriId, DocVec))
parseTsv =
  bufferize 128 >>> parseBytes B.rowUriIdAndDocVec
