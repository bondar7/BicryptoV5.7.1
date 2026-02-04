"use client";
import React from "react";
import DataTable from "@/components/blocks/data-table";
import { useTranslations } from "next-intl";
import { columns } from "./columns";

export default function ForexMarketPage() {
  const t = useTranslations("dashboard");

  return (
    <div className="space-y-6">
      <DataTable
        apiEndpoint="/api/admin/forex/market"
        model="forexMarket"
        permissions={{
          access: "access.forex.account",
          view: "access.forex.account",
          create: "access.forex.account",
          edit: "access.forex.account",
          delete: "access.forex.account",
        }}
        pageSize={20}
        canCreate={false}
        canEdit={true}
        canDelete={false}
        canView={true}
        title={t("forex_markets") || "Forex Markets"}
        itemTitle={t("forex_market") || "Forex Market"}
        columns={columns}
        isParanoid={false}
      />
    </div>
  );
}
