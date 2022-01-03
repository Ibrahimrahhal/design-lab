//Name:yazan issa alhroub
//ID:0145597


// No. Cycles (including reset)=_______________


////////////////////////////////////////////////////////////////

module HazardDetectionUnit(Flush, pcsrc, takenbranch);
output Flush;
input pcsrc, takenbranch;

OR o1 (Flush,pcsrc, takenbranch);
// implementation details are left to the student……


endmodule
