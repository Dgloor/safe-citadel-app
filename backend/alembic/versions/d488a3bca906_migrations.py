"""migrations

Revision ID: d488a3bca906
Revises: 7e3fdd9172c7
Create Date: 2023-06-14 02:25:15.049130

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = 'd488a3bca906'
down_revision = '7e3fdd9172c7'
branch_labels = None
depends_on = None


def upgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_column('visit', 'name')
    # ### end Alembic commands ###


def downgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column('visit', sa.Column('name', sa.VARCHAR(), autoincrement=False, nullable=False))
    # ### end Alembic commands ###
