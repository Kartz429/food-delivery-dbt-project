"""Regenerate the README charts (SVG) from the built dbt marts.

Usage (after `dbt build`):
    python scripts/generate_charts.py --db dev.duckdb
"""
import argparse
from pathlib import Path
from xml.sax.saxutils import escape

OUT = Path(__file__).resolve().parent.parent / "docs" / "assets"


def bar_chart_svg(title, subtitle, labels, values, value_fmt="{:,.0f}", color="#2f6feb"):
    w, row_h, left, top, right = 640, 44, 130, 78, 90
    h = top + row_h * len(labels) + 30
    mx = max(values) if values else 1
    parts = [
        f'<svg xmlns="http://www.w3.org/2000/svg" width="{w}" height="{h}" viewBox="0 0 {w} {h}" role="img" aria-label="{escape(title)}">',
        f'<rect width="{w}" height="{h}" rx="10" fill="#ffffff" stroke="#d0d7de"/>',
        f'<text x="24" y="36" font-family="Segoe UI, Helvetica, Arial, sans-serif" font-size="18" font-weight="600" fill="#1f2328">{escape(title)}</text>',
        f'<text x="24" y="58" font-family="Segoe UI, Helvetica, Arial, sans-serif" font-size="12" fill="#57606a">{escape(subtitle)}</text>',
    ]
    for i, (lab, val) in enumerate(zip(labels, values)):
        y = top + i * row_h
        bw = 0 if mx == 0 else (w - left - right) * val / mx
        parts += [
            f'<text x="{left - 12}" y="{y + 20}" text-anchor="end" font-family="Segoe UI, Helvetica, Arial, sans-serif" font-size="14" fill="#1f2328">{escape(str(lab))}</text>',
            f'<rect x="{left}" y="{y + 4}" width="{bw:.1f}" height="24" rx="4" fill="{color}"/>',
            f'<text x="{left + bw + 8:.1f}" y="{y + 21}" font-family="Segoe UI, Helvetica, Arial, sans-serif" font-size="13" fill="#1f2328">{value_fmt.format(val)}</text>',
        ]
    parts.append("</svg>")
    return "\n".join(parts)


def write_charts(gmv_rows, status_rows):
    OUT.mkdir(parents=True, exist_ok=True)
    (OUT / "gmv_by_city.svg").write_text(
        bar_chart_svg("GMV by city (delivered orders)", "Source: mart_gmv",
                      [r[0] for r in gmv_rows], [r[1] for r in gmv_rows]),
        encoding="utf-8")
    (OUT / "orders_by_status.svg").write_text(
        bar_chart_svg("Orders by status", "Source: fact_orders",
                      [r[0] for r in status_rows], [r[1] for r in status_rows],
                      value_fmt="{:,.0f}", color="#2da44e"),
        encoding="utf-8")


if __name__ == "__main__":
    import duckdb

    ap = argparse.ArgumentParser()
    ap.add_argument("--db", default="dev.duckdb")
    args = ap.parse_args()
    con = duckdb.connect(args.db, read_only=True)
    gmv = con.execute("select city, gmv from mart_gmv order by gmv desc").fetchall()
    status = con.execute("select status, count(*) from fact_orders group by 1 order by 2 desc").fetchall()
    write_charts(gmv, status)
    print("Charts written to", OUT)
