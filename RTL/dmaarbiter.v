`timescale 1ns / 1ps
/**********************************************************************************
 *
 * DMA arbiter
 *
 **********************************************************************************/
module dmaarbiter (
    output test,
    input clk7m,
    input clk,
    input IORST_n,
    input MASTER_n,
    input SBR_n,
    input SC0,
    input EBG_n,
    input FCS_n,
    input DTACK_n,
    output reg mybus = 0,
    output reg SBG_n = 1,
    output reg EBR_n = 1
);

    assign test = !SBG_n;

    reg RCHNG7 = 0;
    reg RCHNG25 = 0;
    reg REGED7 = 0;
    reg REGED25 = 0;

    always @(*) begin
        if (!IORST_n) begin
            SBG_n <= 1;
        end else begin
            if (!SBR_n && MASTER_n && !EBG_n && REGED7 && !RCHNG7) begin
                SBG_n <= 0;
            end else if (SBR_n && !MASTER_n) begin
                SBG_n <= 1;
            end
        end
    end

    // The Zorro III bus request is driven out on C7M high, for one C7M cycle, to
    // register for bus mastership.  When done, the same sequence relinquishes
    // registration.  The RCHNG signal indicated when a change is necessary.
    always @(negedge IORST_n, posedge clk7m) begin
        if (!IORST_n) begin
            EBR_n = 1;
            REGED7 <= 0;
            RCHNG7 <= 0;
        end else begin
            RCHNG7 <= RCHNG25;
            if (RCHNG7 && EBR_n) begin
                EBR_n = 0;
                REGED7 <= !REGED7;
            end else begin
                EBR_n = 1;
            end
        end
    end

    always @(negedge IORST_n, posedge clk) begin
        if (!IORST_n) begin
            RCHNG25 <= 0;
            REGED25 <= 0;
        end else begin
            REGED25 <= REGED7;
            if (!EBR_n) begin
                RCHNG25 <= 0;
            end else if (!REGED25 && (!SBR_n || SC0)) begin
                RCHNG25 <= 1;
            end else if (REGED25 && MASTER_n && SBR_n && !SC0) begin
                RCHNG25 <= 1;
            end
        end
    end

    always @(*) begin
        if (!IORST_n) begin
            mybus <= 0;
        end else if (REGED7 && !EBG_n) begin
            mybus <= 1;
		end else if (FCS_n && DTACK_n) begin
            mybus <= 0;
        end
    end

endmodule
