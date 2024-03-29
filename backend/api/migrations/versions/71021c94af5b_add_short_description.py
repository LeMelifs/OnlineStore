"""add short description

Revision ID: 71021c94af5b
Revises: 65193885c5da
Create Date: 2024-01-17 15:45:39.799397

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = '71021c94af5b'
down_revision = '65193885c5da'
branch_labels = None
depends_on = None


def upgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column('product', sa.Column('short_description', sa.String(length=70), nullable=True))
    # ### end Alembic commands ###


def downgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_column('product', 'short_description')
    # ### end Alembic commands ###
