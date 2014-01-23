"""rename order column

Revision ID: 2a59d89955a1
Revises: 508fb3a45a86
Create Date: 2013-08-08 14:35:40.391117

"""

# revision identifiers, used by Alembic.
revision = '2a59d89955a1'
down_revision = '508fb3a45a86'

from alembic import op
import sqlalchemy as sa


def upgrade():
    op.alter_column('game', u'order',  name='play_order')


def downgrade():
    op.alter_column('game', u'play_order',  name='order')
