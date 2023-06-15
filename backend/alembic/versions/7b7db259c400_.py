"""empty message

Revision ID: 7b7db259c400
Revises: 2c732117112b
Create Date: 2023-06-14 19:16:48.185059

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = '7b7db259c400'
down_revision = '2c732117112b'
branch_labels = None
depends_on = None


def upgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column('user', sa.Column('password', sa.String(), nullable=True))
    op.add_column('user', sa.Column('is_active', sa.Boolean(), nullable=True))
    op.create_unique_constraint(None, 'user', ['password'])
    # ### end Alembic commands ###


def downgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_constraint(None, 'user', type_='unique')
    op.drop_column('user', 'is_active')
    op.drop_column('user', 'password')
    # ### end Alembic commands ###
