module Metrix.DocVecsReading.Foldl where

import Metrix.DocVecsReading.Prelude
import Metrix.NlpData
import Metrix.ClickstreamData
import Control.Foldl
import qualified Data.Vector.Unboxed as A
import qualified Data.IntMap as B


lookup :: Fold (Int, A.Vector Float) (UriId -> Maybe DocVec)
lookup =
  Fold step init end
  where
    step !table (!key, !vector) =
      B.insert key vector table
    init =
      B.empty
    end !table (UriId key) =
      fmap (DocVec . A.convert . A.map realToFrac) (B.lookup (fromIntegral key) table)
